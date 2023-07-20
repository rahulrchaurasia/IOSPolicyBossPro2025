//
//  Extension+UIViewController.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 30/03/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess



//////////////////////// Extension For ViewController
extension UIViewController {
    
    
    
    static var appVersion: String? {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        }

    func getDevice(){
        
      

        let device = UIDevice.current

        // Get the device name (e.g. "iPhone")
        let deviceName = device.name

        // Get the device model (e.g. "iPhone" or "iPad")
        let deviceModel = device.model

        // Get the system name (e.g. "iOS")
        let systemName = device.systemName

        // Get the system version (e.g. "14.3")
        let systemVersion = device.systemVersion

        // Get the device UUID
        let deviceUUID = device.identifierForVendor?.uuidString

        // Get the device type (e.g. .phone or .pad)
        let deviceType = device.userInterfaceIdiom

    }
    
    func getDeviceID() -> String{
        

        if  getDeviceInKeyChain().isEmpty{
               
            return saveDeviceInKeyChain() ?? ""
          
                
        }else{
            
           return getDeviceInKeyChain()
        }
       
    }
    func  getDeviceInKeyChain() -> String{
        
        
        let keychain  = Keychain(service: Constant.PbKeychain)
        
       // keyChainData = keychain["HighScore"] ?? "No Data"
        
        print("KeyStore Data get",keychain[string : Constant.DeviceDetail] ?? "No Data")
        
        return keychain[string : Constant.DeviceDetail] ?? ""
        
    }
    
    func  saveDeviceInKeyChain() -> String?{
       
            let deviceID =  UIDevice.current.identifierForVendor?.uuidString
            let keychain = Keychain(service: Constant.PbKeychain)
            keychain[Constant.DeviceDetail] = deviceID
            print("KeyStore Data Stored")
            
           return deviceID
      }
    func removeDeviceIDKeyChain(){
        do {
            let keychain  = Keychain(service: Constant.PbKeychain)
            try keychain.remove(Constant.PbKeychain)
        } catch let error {
            print("error keychain: \(error)")
        }
    }
    
    func getDeviceName() -> String{
        

        // Get the device name
        return UIDevice.current.name

       
    }
    
    func getDeviceOS() -> String{
        

        // Get the device name
        return UIDevice.current.systemName + "" + UIDevice.current.systemVersion

       
    }

    func showToast(controller: UIViewController,message : String, seconds : Double){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
    
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      
        // Move to the UI thread
        DispatchQueue.main.async(execute: { () -> Void in
            // Present Alert Controller
              self.present(alert, animated: true, completion: nil)
        })
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func moveToHome(){
        
        
        let KYDrawer : KYDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "stbKYDrawerController") as! KYDrawerController
        KYDrawer.modalPresentationStyle = .fullScreen
        KYDrawer.modalTransitionStyle = .coverVertical
        present(KYDrawer, animated: false, completion: nil)
        
        
        
    }
    func dismissAll(animated: Bool, completion: (() -> Void)? = nil) {
        if let optionalWindow = UIApplication.shared.delegate?.window, let window = optionalWindow, let rootViewController = window.rootViewController, let presentedViewController = rootViewController.presentedViewController  {
            if let snapshotView = window.snapshotView(afterScreenUpdates: false) {
                presentedViewController.view.addSubview(snapshotView)
                presentedViewController.modalTransitionStyle = .coverVertical
            }
            if !isBeingDismissed {
                rootViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    
    //-------< For Hide Keyboard >--------
    // Put this piece of code anywhere you like
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func CheckPermissionAlert(_title : String , _message : String){
        
        
        let alertController = UIAlertController(title: _title, message: _message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
        // check the permission status
        //       ...................................................................//
        
        
    }
    
    class func initiateFromStoryboard(name : String) -> Self
    {
        return initiateFromStoryboardHelper(name)
    }
    
    fileprivate class func initiateFromStoryboardHelper<T>(_ name : String) -> T {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as!  T
        
        return controller
    }
    
}


extension UIView
{
    func removeAllSubViews()
    {
        for subView :AnyObject in self.subviews
        {
            subView.removeFromSuperview()
        }
    }
    
}
