//
//  WEPersonalization.swift
//  PersonalizationSDK
//
//  Created by Unmesh Rathod on 15/06/21.
//

import UIKit
import WebEngage

@objcMembers
public class WEPersonalization: NSObject, InLineNotificationsProtocol {
    
    public static var shared: WEPersonalization = WEPersonalization()
    public let operationQueue = OperationQueue()
    var systemData:[String:Any]? = nil
    var operationsGroup:DispatchGroup? = nil
    private let serialQueue = DispatchQueue(label: "serialQueuePersonalization")
    
    // Debug variables
    var countCheck = 0
    var processingProperties:Bool{
        return (countCheck != 0)
    }
    var propertyRegistryCallbacks:PropertyRegistryCallback? = nil
    
    //MARK: - Initializers
    public func initialise(){}
    
    private override init() {
        super.init()
        WELogger.initLogger()
        WebEngage.sharedInstance().setInLineDelegates(self)
        
      
    }
    
    //MARK: - Delegates from Core SDK
    
    public func propertiesReceived(_ inLineProperties:  [AnyHashable : Any]) {
        
//        var shouldProcessExecution = true
        
        // Already processing properties so cancell all previous operations first
        if self.processingProperties == true{
            WELogger.d("WEP: Cancel all existing operations and restart")
            self.operationQueue.cancelAllOperations()
//            shouldProcessExecution = true
        }
        
//        if shouldProcessExecution == true{
            WELogger.d("WEP: Properties received in Personalization SDK \(inLineProperties)");
            // Store system data globally using for all n/w calls
            systemData = inLineProperties["systemData"] as? [String:Any]
        
            // this is used when we start operation for load of inineview
            // load of inlineview should not start any operation if properties are processing from page navigated
            WEPropertyRegistry.shared.setPageNavigationRefreshStarted(value: true)
            WELogger.d("WEP: Property Refresh from screen navigated has been started")
            operationsGroup = DispatchGroup()
            if let properties = inLineProperties["properties"] as? [JSON]{
                let propertiesModels = properties.map({return WEPropertyData(dictionary: $0)})
                propertiesModels.forEach { details in
                    if let targeviewIdString = details.targetView,
                       let targetViewId = Int(targeviewIdString){
                        
                        // store property Details in Property Registry
                        WEPropertyRegistry.shared.storePropertyDetails(forTag: targetViewId,
                                                                       details: details)
                        
                        // Create propertyProcessor operation and start
                        self.enterInToGroup()
                        let ppOperation = WEPropertyProcessor(propertyDetails: details)
                        ppOperation.enteredInDispatchGroup = true
                        operationQueue.addOperation(ppOperation)
                    }else{
                        WELogger.d("WEP: target view id is invalid")
                    }
                }
            }
            
            // udpate value that page navigated screen refresh and processing all properties has been finished
            operationsGroup?.notify(queue: .main) {
                WELogger.d("WEP: Property Refresh from screen navigated has been completed")
                WEPropertyRegistry.shared.setPageNavigationRefreshStarted(value: false)
                self.operationsGroup = nil
            }
//        }
        
    }
    
    public func screenNavigated(to screenDetails: [AnyHashable : Any]) {
        // Screen navigated callback
        // remove all cache
        // removing check for hybrid : hybrid is dependant on callbacks
//        if self.processingProperties == false{
            WEPropertyRegistry.shared.clearCache(for: screenDetails)
//        }
    }
    
    public func registerPropertyRegistryCallbacks(_ callback:PropertyRegistryCallback){
        self.propertyRegistryCallbacks = callback
    }
    
    public func enterInToGroup(){
        serialQueue.sync{
            operationsGroup?.enter()
        }
    }
    public func exitFromGroup(){
        serialQueue.sync{
            operationsGroup?.leave()
        }
    }
    

    //MARK: -  Helper functions for callbacks
    // this is written over here to keep consistancy between android and ios
    // android is already production live
    
    public func registerWECampaignCallback(_ callback:WECampaignCallback){
        WECallbackManager.shared.registerCampaignCallback(callback)
    }
    
    public func registerWEPlaceholderCallback(_ targetViewId:Int,_ callback:WEPlaceholderCallback){
        WECallbackManager.shared.registerPlaceHolderCallback(tag: targetViewId, callback: callback)
    }
    
    public func unregisterWECampaignCallback(_ callback:WECampaignCallback){
        WECallbackManager.shared.deregisterCampaignCallback(callback)
    }
    
    public func unregisterWEPlaceholderCallback(_ targetViewId:Int){
        WECallbackManager.shared.deregisterPlaceholderCallback(tag: targetViewId)
    }
    
    //MARK: - Click helpers
    @objc internal func campaignButtonTapped(sender: WEButton) {
        WELogger.d("WEP: campaign button tapped")
        
        if let contentView = getWEPersonalizationViewInSuperviews(view: sender){
            if let campaignData = contentView.campaignData{
                
                let actionsDetails = sender.getActionProperties()
                self.passCallback(campaignData: campaignData, sender: sender, actionDetails: actionsDetails)
            }
        }
    }
    
    func redirectToUrlIfRequired(actionsDetails:(String?, String?)){
        if let urlStr = actionsDetails.0{
            guard let url = URL(string: urlStr) else {
                return //be safe
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc internal func campaignViewTapped(sender: Any) {
        WELogger.d("WEP: campaign view tapped")
        if let contentView = getWEPersonalizationViewInSuperviews(view: (sender as! UIView)),
            let campaignData = contentView.campaignData{
                if let view = sender as? WEView{
                    WELogger.d("Click: View \(campaignData.campaignId ?? "")")
                    let actionDetails = view.getActionProperties()
                    passCallback(campaignData: campaignData, sender: sender, actionDetails: actionDetails)
                } else if let imageView = sender as? WEImageView{
                    WELogger.d("Click: Image \(campaignData.campaignId ?? "")")
                    let actionDetails = imageView.getActionProperties()
                    passCallback(campaignData: campaignData, sender: sender, actionDetails: actionDetails)
                }else if let label = sender as? WELabel{
                    WELogger.d("Click: Label \(campaignData.campaignId ?? "")")
                    let actionDetails = label.getActionProperties()
                    passCallback(campaignData: campaignData, sender: sender, actionDetails: actionDetails)
                }
            }
    }
    
    func passCallback(campaignData:WECampaignData,sender:Any,actionDetails:(actionUrl: String, cta: String)){
        campaignData.trackClick(actionDetails: actionDetails,attributes: nil)
        if campaignData.campaignId != nil{
            let callbacks = WECallbackManager.shared.getGlobalCampaignCallbacks()
            callbacks.forEach { callback in
                let shouldRedirect = callback.onCampaignClicked?(actionId: actionDetails.cta,
                                                                 deepLink: actionDetails.actionUrl,
                                                                 data: campaignData)
                if shouldRedirect == false{
                    self.redirectToUrlIfRequired(actionsDetails: actionDetails)
                }
            }
            if callbacks.count == 0{
                self.redirectToUrlIfRequired(actionsDetails: actionDetails)
            }
        }
    }
    
    public func clearUIinPrepareForReuse(view:UIView){
        if let webEngageView = getWEPersonalizationViewInSubviews(view: view){
            webEngageView.removeFromSuperview()
            WELogger.d("WEPI: removing existing view \(view.tag)")
        }else{
//            Logger.d("WEPI: Existing view not found to remove \(view.tag)")
        }
    }
    
}
