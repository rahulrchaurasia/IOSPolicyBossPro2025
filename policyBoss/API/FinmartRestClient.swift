//
//  FinmartRestClient.swift
//  MagicFinmart
//
//  Created by Ashwini on 29/12/18.
//  Copyright © 2018 Ashwini. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FinmartRestClient {
    
    //MARK:- Nykaa Base URL
    
    static let baseURLString = Configuration.baseURLString
    static let baseURLROOT = Configuration.baseROOTURL
    
    static let baseFileUploadURLString = Configuration.baseFileUploadURLString
    static let baseServiceURLString = Configuration.baseServiceURLString
    static let baseEncryptedErpIdURLString = Configuration.baseEncryptedErpIdURL
    static let basegenerateloanLeadURLString = Configuration.basegenerateloanLeadURL
    static let basehealthassureURLString = Configuration.basehealthassureURL
    
    
    /// new Created
    
   static let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "token": "1234567890"
    ]
    
    /**
     * Server key in the returned JSON where the success/failure status is
     * stored
     */
    fileprivate static let STATUS_KEY = "status";
    fileprivate static let STATUS_ID_KEY = "status_Id";
    fileprivate static let STATUSID_KEY = "statusId";
    fileprivate static let STATUS = "Status";
    
    var healthAresponseType = ""
    
    /**
     * Server key in the returned JSON where type of response is stored
     * (array/object)
     */
    fileprivate static let TYPE_KEY = "type";
    
    /**
     * {@link ResponseListener#TYPE_KEY} value denoting response is array
     */
    fileprivate static let ARRAY_TYPE = "array";
    
    /**
     * {@link ResponseListener#TYPE_KEY} value denoting response is object
     */
    fileprivate static let OBJECT_TYPE = "object";
    
    /**
     * {@link ResponseListener#TYPE_KEY} value denoting response is string
     */
    fileprivate static let STRING_TYPE = "string";
    
    /**
     * {@link ResponseListener#STATUS_KEY} value denoting response is
     * success
     */
    fileprivate static let FAILED_STATUS = "Failed";
    
    /**
     * {@link ResponseListener#STATUS_KEY} value denoting response is
     * success
     */
    fileprivate static let UNKNOWN_STATUS = "false";
    
    /**
     * {@link ResponseListener#STATUS_KEY} value denoting response is
     * success
     */
    fileprivate static let SUCCESS_STATUS = "success";
    
    /**
     * Server key in the returned JSON for the response
     */
    fileprivate static let RESPONSE_KEY = "response";
    
    fileprivate static let DATA_KEY = "data";
    
    fileprivate static let APPLICATION_KEY = "application";
    
    fileprivate static let RESPONSE_KEY_RESULT = "MasterData";
    
    /**
     * Server key in the returned JSON for the error is there is on
     */
    fileprivate static let ERROR_KEY = "error";
    
    fileprivate static let STATUS_ID = "statusId";
    
    /**
     * Server key in the returned {@link ResponseListener#ERROR_KEY} JSON
     * for the error message
     */
    //fileprivate static let ERROR_MESSAGE_KEY = "message";
    
    fileprivate static let ERROR_MESSAGE_KEY = "Message";
    
    
    fileprivate static let ERROR_IMAGE_URL = "image_url";
    /**
     * Error code value in the returned JSON for the force upgrade error
     */
    fileprivate let FORCE_UPGRADE_ERROR_CODE = 5001;
    /**
     * Error code value in the returned JSON for the soft upgrade error
     */
    fileprivate let SOFT_UPGRADE_ERROR_CODE = 5000;
    /**
     * Type of upgrade softe upgrade or force upgrade
     */
    fileprivate let USER_CREDENTIALS_ERROR_CODE = 1003
    
    fileprivate let USER_ALREADY_EXISTS_FB_ERROR_CODE = 1500
    
    fileprivate let TYPE_OF_UPGRADE_KEY = "type";
    fileprivate let UPGRADE_IMAGE_KEY = "image";
    fileprivate let UPGRADE_TEXT_KEY = "text";
    
    fileprivate var request: Alamofire.Request?
    fileprivate var sessionManager : Alamofire.SessionManager?
    
    static var shouldIgnoreCacheData:Bool = false
    static let sharedInstance = FinmartRestClient()
    
    private init()
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = CommonSettings.API_CALLS_TIMEOUT
        //configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Content-Type")
//        configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
        configuration.httpAdditionalHeaders?.updateValue("1234567890", forKey: "token")

        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func authorisedPost(_ url : String,parameters : [String : AnyObject], onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata?) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void,onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void, service : Bool = false, checkStatus : Bool = false, checkLead : Bool = false, healthAssure : Bool = false){
        //let user = User.getInstance(nil)
        var authorizeParams : [String : AnyObject ] =  parameters
        
        authorizeParams["appTypeId"] = "4" as AnyObject?
        //authorizeParams.insert ["appTypeID" : "4" as AnyObject]
        //let userStatus : User.UserStatus  = User.getUserStatus()
        //        if userStatus == User.UserStatus.LoggedIn
        //        {
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_TOKEN] = user.authenticationToken as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_CUSTOMER_ID] = user.customerId as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_ID] = user.customerId as AnyObject?
        //        }
        //        authorizeParams[UserAPI.APPLICATION_POST_KEY_APP_VERSION_IOS] = UIApplication.appVersion() as AnyObject?
        var urlRequest : String
                if(service){
                    urlRequest = self.setUpServiceApiURL(url, method: .post, parameters: authorizeParams)
                }
                else if(checkStatus){
                    urlRequest = self.setUpERPApiURL(url, method: .post, parameters: authorizeParams)
                }
                else if(checkLead){
                    urlRequest = self.setUploanLeadURL(url, method: .post, parameters: authorizeParams)
                }
                else if(healthAssure){
                    urlRequest = self.sethealthAssureURL(url, method: .post, parameters: authorizeParams)
                }
                else{
                    urlRequest = self.setUpApiURL(url, method: .post, parameters: authorizeParams)
                }
//        urlRequest = self.setUpApiURL(url, method: .post, parameters: authorizeParams)
        apiCall(.post, urlRequest: urlRequest, parameters: authorizeParams, onSuccess: onSuccess , onError: onError,onForceUpgrade:onForceUpgrade, checkStatus: checkStatus)
    }
    
    //For Direct AlamoFire
    func authorisedPostDirect(_ url : String,parameters : [String : AnyObject], onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata?) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void,onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void){
        //let user = User.getInstance(nil)
        let authorizeParams : [String : AnyObject ] =  parameters
        //let userStatus : User.UserStatus  = User.getUserStatus()
        //        if userStatus == User.UserStatus.LoggedIn
        //        {
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_TOKEN] = user.authenticationToken as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_CUSTOMER_ID] = user.customerId as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_ID] = user.customerId as AnyObject?
        //        }
        //        authorizeParams[UserAPI.APPLICATION_POST_KEY_APP_VERSION_IOS] = UIApplication.appVersion() as AnyObject?
        let urlRequest = self.setUpApiURL(url, method: .post, parameters: authorizeParams)
        
        Alamofire.request(urlRequest, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
        }
        
        //   apiCall(.post, urlRequest: urlRequest, parameters: authorizeParams, onSuccess: onSuccess , onError: onError,onForceUpgrade:onForceUpgrade)
    }
    
    
    func authorisedMultipartForm(_ url : String,parameters : [String : AnyObject], onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata?) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void,onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void){
        //let user = User.getInstance(nil)
        let authorizeParams : [String : AnyObject ] =  parameters
        //        let userStatus : User.UserStatus  = User.getUserStatus()
        //        if userStatus == User.UserStatus.LoggedIn
        //        {
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_TOKEN] = user.authenticationToken as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_CUSTOMER_ID] = user.customerId as AnyObject?
        //            authorizeParams[UserAPI.USERS_POST_KEY_AUTH_ID] = user.customerId as AnyObject?
        //        }
        //        authorizeParams[UserAPI.APPLICATION_POST_KEY_APP_VERSION_IOS] = UIApplication.appVersion() as AnyObject?
        let urlRequest = self.setUpApiURL(url, method: .post, parameters: authorizeParams)
        
        apiFormDataCall(.post , urlRequest: urlRequest, parameters: authorizeParams, onSuccess: onSuccess , onError: onError,onForceUpgrade:onForceUpgrade)
        
        
    }
    
    func authorisedGet(_ url : String,parameters : [String : AnyObject]?, onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void, onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void) {
        var authorizeParams = [String : AnyObject ]()
        if parameters != nil {
            authorizeParams =  parameters!
        }
        //        authorizeParams[UserAPI.APPLICATION_POST_KEY_APP_VERSION_IOS] = UIApplication.appVersion() as AnyObject?
        let urlRequest = self.setUpApiURL(url, method: .get, parameters: authorizeParams)
        apiCall(.get, urlRequest: urlRequest, parameters: authorizeParams, onSuccess: onSuccess,onError:onError,onForceUpgrade:onForceUpgrade)
    }
    
    func cancelAlamofireRequest(){
        if self.request != nil {
            self.request!.cancel()
        }
    }
    
    func apiFormDataCall(_ method : Alamofire.HTTPMethod , urlRequest : String,parameters : [String : AnyObject], onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void, onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void)
    {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                if key == "image" {
                    let valueAsArray = value as! NSMutableArray
                    for i in 0..<valueAsArray.count{
                        let newImageData = valueAsArray.object(at: i)
                        multipartFormData.append((newImageData as? Data)!, withName: "image\(i)", fileName: "image\(i).png", mimeType: "image/png")
                    }
                }
                else{
                    let value1 = value as? NSString
                    multipartFormData.append((value1?.data(using : String.Encoding.utf8.rawValue)!)!, withName: key)
                    
                }
            }
        }, to:urlRequest)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    // NykaaLog.print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON(completionHandler:{
                    response in
                    //print response.result
                    // NykaaLog.print("response Progress: \(response)")
                    if let jsonResponse = response.result.value{
                        if JSONSerialization.isValidJSONObject(jsonResponse){ //is json is valid?
                            let json = JSON(jsonResponse) //convert it to a JSON
                            //Check response type
                            let responseType = json[FinmartRestClient.TYPE_KEY].stringValue
                            //is it a failed response
                            if json[FinmartRestClient.STATUS_KEY].stringValue == FinmartRestClient.FAILED_STATUS
                            {
                                //is ErrorKey in response is not nil?
                                if json[FinmartRestClient.ERROR_KEY] != JSON.null
                                {
                                    let errorCode = json[FinmartRestClient.ERROR_KEY].intValue
                                    //is it soft Upgrade?
                                    if errorCode == self.SOFT_UPGRADE_ERROR_CODE
                                    {
                                        self.handleUpgradeData(json, errorCode: errorCode)  //Set soft uprade data from response
                                        //Handle Response
                                        self.handleSuccessResponse(responseType, json: json, onSuccess: { (response) -> Void in
                                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                                        }, onError: { (responseError) -> Void in
                                            onError(responseError)})
                                    }
                                        //is it force upgrdade
                                    else if errorCode == self.FORCE_UPGRADE_ERROR_CODE{
                                        self.handleUpgradeData(json, errorCode: errorCode)  //Set force uprade data from response
                                        //call forceUpgrade block
                                        onForceUpgrade(ResponseMetadata(type: ResponseMetadata.ResponseType.errorWithForceUpgrade))
                                    }
                                    else if errorCode == self.USER_CREDENTIALS_ERROR_CODE {     //Incase user's credenitials get expiered
                                        let credentialError:ResponseMetadata = self.handleError(response.result.error as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: errorCode)
                                        self.handleExpiredCredentialError(credentialError)
                                    }
                                    else  //incase there is other in situation
                                    {
                                        onError(self.handleError(response.result.error as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: errorCode))
                                    }
                                }
                                else //Error Key in response is nil
                                {
                                    onError(self.handleError(response.result.error as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
                                }
                            }
                                //is it success response
                            else if json[FinmartRestClient.STATUS_KEY].stringValue == FinmartRestClient.SUCCESS_STATUS
                            {   //Handle Response
                                self.handleSuccessResponse(responseType, json: json, onSuccess: { (response) -> Void in
                                    onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                                }, onError: { (responseError) -> Void in
                                    onError(responseError)})
                            }
                            else //if there is error in response
                            {
                                onError(self.handleError(response.result.error as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
                            }
                        }
                        else //if response in not valid JSON
                        {
                            onError(self.handleError(response.result.error as AnyObject?, json:nil, type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
                        }
                        
                    }
                    else //if response is empty
                    {
                        onError(self.handleError(response.result.error as AnyObject?, json:nil, type: ResponseMetadata.ResponseType.errorNoServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorNoServerResponse, errorCode: nil))
                    }
                })
                
                upload.responseString { response in
                    //print response.result
                    PBLogs.print("response Progress: \(response)")
                    if let jsonResponse = response.result.value{
                        // if JSONSerialization.isValidJSONObject(jsonResponse){ //is json is valid?
                        let json = JSON(jsonResponse) //convert it to a JSON
                        //Check response type
                        _ = json[FinmartRestClient.TYPE_KEY].stringValue
                        self.handleSuccessResponse("object", json: json, onSuccess: { (response) -> Void in
                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                        }, onError: { (responseError) -> Void in
                            onError(responseError)})
                        // }
                    }
                    
                }
                
            case .failure(let encodingError):
                PBLogs.print(encodingError)
                let json = JSON(encodingError) //convert it to a JSON
                
                onError(self.handleError(encodingError as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: 0))
            }
        }
    }
    
    func apiCall(_ method : Alamofire.HTTPMethod , urlRequest : String,parameters : [String : AnyObject], onSuccess : @escaping (_ res : AnyObject,_ metaData:ResponseMetadata) -> Void  , onError : @escaping (_ errorData : ResponseMetadata) -> Void, onForceUpgrade:@escaping (_ errorData:ResponseMetadata) -> Void, service : Bool = false, checkStatus : Bool = false, checkLead : Bool = false, healthAssure : Bool = false)
    {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "token": "1234567890"
        ]
        
        self.request = Alamofire.request(urlRequest, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { (response) in
            print("urlRequest=",urlRequest)
            print("parameters=",parameters)
            print("response=",response)
            if let jsonResponse = response.result.value{
                if JSONSerialization.isValidJSONObject(jsonResponse){
                    let json = JSON(jsonResponse)
                    print("json=",json)
//                    if(healthAssure == false){
                        let d = (jsonResponse as AnyObject).value(forKey: "d") as AnyObject
//                        print("d= ", d)
                    if(d is NSNull){
                       print("NSNull")
                    }else {
                        let json = JSON(d)
                        print("json=",json)
                        let status = d.value(forKey: "status") as! String
//                        print("status= ", status)
                        self.healthAresponseType = status
                        print("healthAresponseType=",self.healthAresponseType)
                    }
//                    }
                    //let responseType = json[BeldaraRestClient.TYPE_KEY].stringValue
                    let responseType = json[FinmartRestClient.STATUS].stringValue
                    print("responseType=",responseType)
                    let responseType1 = json[FinmartRestClient.STATUS_KEY].stringValue
                    print("responseType1=",responseType1)
                    let messge = json[FinmartRestClient.ERROR_MESSAGE_KEY].stringValue
                    print("messge=",messge)
                    UserDefaults.standard.set(String(describing: messge), forKey: "messge")
                    
                    //                    if(responseType == ""){
                    //                        responseType = json[BeldaraRestClient.STATUS_KEY].stringValue
                    //                        if(responseType == ""){
                    //                            responseType = json[BeldaraRestClient.STATUSID_KEY].stringValue
                    //                        }
                    //                    }
                    
                    if(responseType1 == "success"){
                        self.handleSuccessResponse("0", json: json, onSuccess: { (response) -> Void in
                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                        }, onError: { (responseError) -> Void in
                            onError(responseError)})
                    }
                    else if(self.healthAresponseType == "Success"){
                        self.handleSuccessResponse("0", json: json, onSuccess: { (response) -> Void in
                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                        }, onError: { (responseError) -> Void in
                            onError(responseError)})
                    }
                    else if(responseType == "success"){
                        self.handleSuccessResponse("0", json: json, onSuccess: { (response) -> Void in
                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                        }, onError: { (responseError) -> Void in
                            onError(responseError)})
                    }
                    else{
                        self.handleSuccessResponse("1", json: json, onSuccess: { (response) -> Void in
                            onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                        }, onError: { (responseError) -> Void in
                            onError(responseError)})
                    }
                    
                    /*        if(!checkStatus){
                     self.handleSuccessResponse("0", json: json, onSuccess: { (response) -> Void in
                     onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                     }, onError: { (responseError) -> Void in
                     onError(responseError)})
                     }
                     else
                     {
                     if(json[BeldaraRestClient.STATUSID_KEY].stringValue == "1"){
                     self.handleSuccessResponse("0", json: json, onSuccess: { (response) -> Void in
                     onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                     }, onError: { (responseError) -> Void in
                     onError(responseError)})
                     }
                     else if json[BeldaraRestClient.STATUS_KEY].stringValue == BeldaraRestClient.FAILED_STATUS || json[BeldaraRestClient.STATUS_ID_KEY].stringValue == "1"
                     {
                     //if json[BeldaraRestClient.ERROR_KEY] != JSON.null
                     //{
                     let errorCode = json[BeldaraRestClient.STATUS_ID].intValue
                     onError(self.handleError(response.result.error as AnyObject?, json:json, type: ResponseMetadata.ResponseType.errorWithServerResponse,optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: errorCode))
                     // }
                     }
                     else if json[BeldaraRestClient.STATUS_KEY].stringValue == BeldaraRestClient.SUCCESS_STATUS || json[BeldaraRestClient.STATUS_ID_KEY].stringValue == "0"
                     {
                     
                     if (parameters["Application"] as? String) != nil {
                     self.handleApplicationSuccessResponse(responseType, json: json, onSuccess: { (response) -> Void in
                     onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                     }, onError: { (responseError) -> Void in
                     onError(responseError)})
                     
                     }
                     else
                     {
                     self.handleSuccessResponse(responseType, json: json, onSuccess: { (response) -> Void in
                     onSuccess(response, ResponseMetadata(type: ResponseMetadata.ResponseType.success))
                     }, onError: { (responseError) -> Void in
                     onError(responseError)})
                     }
                     }
                     }*/
                }
            }
        }
    }
    
    //Function to handle success response
    func handleSuccessResponse(_ responseType:String,json:JSON,onSuccess : (_ response:AnyObject) -> Void,onError:(_ responseError:ResponseMetadata)->Void){
        
        if responseType == "0" //is response is Object
        {
            
            //            if let dict = json[BeldaraRestClient.DATA_KEY].arrayObject //is respose key has value?
            //            {
            //                onSuccess(dict as AnyObject)
            //            }
            //            else if let dict = json[BeldaraRestClient.DATA_KEY].dictionaryObject //is respose key has value?
            //            {
            //                onSuccess(dict as AnyObject)
            //            }
            //            else
            if let dict = json[FinmartRestClient.RESPONSE_KEY_RESULT].dictionaryObject //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json[FinmartRestClient.RESPONSE_KEY_RESULT].arrayObject //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json[FinmartRestClient.RESPONSE_KEY_RESULT].bool //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json[FinmartRestClient.RESPONSE_KEY_RESULT].int //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json[FinmartRestClient.RESPONSE_KEY_RESULT].string //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json["SwipeDetails"].arrayObject //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json["Url"].string //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json["result"].dictionaryObject
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json["result"].arrayObject
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json["d"].dictionaryObject
            {
                onSuccess(dict as AnyObject)
            }
            else if let dict = json.dictionaryObject
            {
                onSuccess(dict as AnyObject)
            }
            else{
                
                //is response key is empty.
                onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
            }
        }
        else{
            onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
        }
        
        /*  else if responseType == BeldaraRestClient.OBJECT_TYPE //is response is Object
         {
         if let dict = json[BeldaraRestClient.RESPONSE_KEY].dictionaryObject //is respose key has value?
         {
         onSuccess(dict as AnyObject)
         }
         else{   //is response key is empty.
         onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
         }
         }
         else if responseType == BeldaraRestClient.ARRAY_TYPE //is response is Array
         {
         if let dict = json[BeldaraRestClient.RESPONSE_KEY].arrayObject    //is respose key has value?
         {
         onSuccess(dict as AnyObject)
         }
         else
         {   //is response key is empty.
         onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
         }
         }
         else if responseType == BeldaraRestClient.STRING_TYPE //is response is Array
         {
         if let dict = json[BeldaraRestClient.RESPONSE_KEY].string   //is respose key has value?
         {
         onSuccess(dict as AnyObject)
         }
         else
         {   //is response key is empty.
         onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
         }
         }
         if responseType == BeldaraRestClient.SUCCESS_STATUS //is response is Object
         {
         
         //onSuccess(json[BeldaraRestClient.RESPONSE_KEY_RESULT] as AnyObject)
         if let dict = json[BeldaraRestClient.RESPONSE_KEY_RESULT].dictionaryObject //is respose key has value?
         {
         onSuccess(dict as AnyObject)
         }
         else if let dict = json[BeldaraRestClient.RESPONSE_KEY_RESULT].arrayObject //is respose key has value?
         {
         onSuccess(dict as AnyObject)
         }
         else{   //is response key is empty.
         if json["status"].string == "success"{
         if let dict = json["enable_button"].bool{
         onSuccess(dict as AnyObject)
         }
         else{
         onSuccess(json["status"].string as AnyObject)
         }
         }else{
         onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
         }
         }
         }
         else //incase there is diffrent type of response
         {
         onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
         }
         */
    }
    
    
    
    
    func handleApplicationSuccessResponse(_ responseType:String,json:JSON,onSuccess : (_ response:AnyObject) -> Void,onError:(_ responseError:ResponseMetadata)->Void){
        
        if responseType == "0" //is response is Object
        {
            
            if let dict = json[FinmartRestClient.APPLICATION_KEY].arrayObject //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            if let dict = json[FinmartRestClient.DATA_KEY].dictionaryObject //is respose key has value?
            {
                onSuccess(dict as AnyObject)
            }
            else{   //is response key is empty.
                onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
            }
        }
        else //incase there is diffrent type of response
        {
            onError(self.handleError(nil,json:json,type: ResponseMetadata.ResponseType.errorWithServerResponse, optionalErrorType: ResponseMetadata.ResponseType.errorWithServerResponse, errorCode: nil))
        }
    }
    
    //Function To Handle Error.
    func handleError(_ errorData: AnyObject?, json: JSON?, type: ResponseMetadata.ResponseType, optionalErrorType: ResponseMetadata.ResponseType, errorCode: Int?) -> ResponseMetadata {
        
        if let json = json {
     
            
            // JSON is not nil
            
            if let dict = json[FinmartRestClient.RESPONSE_KEY].dictionaryObject as [String : AnyObject]?, let _ = dict["sign_up_source"] as? String {
                var errorMessage : String? = json[FinmartRestClient.ERROR_MESSAGE_KEY].stringValue
                if errorMessage == nil {
                    errorMessage = ""
                }
                return ResponseMetadata(type: ResponseMetadata.ResponseType.errorWithServerResponse, data: dict as AnyObject?,error: nil, errorMessage: errorMessage!)
            }
                
            else if json[FinmartRestClient.ERROR_MESSAGE_KEY] != JSON.null { //check for error message in json
                let errorMessage = json[FinmartRestClient.ERROR_MESSAGE_KEY].stringValue
                let dict = json.dictionaryObject as [String : AnyObject]?
                return ResponseMetadata(type: type, data: dict as AnyObject?, error: nil, errorMessage: errorMessage, errorCode: errorCode)
            }
                
            else //if there is no error message in json
            {
                return ResponseMetadata.getError(optionalErrorType)
            }
        }
        else {
            // JSON is nil
            
            if let resError = errorData as? NSError //is there any nsError?
            {
                return ResponseMetadata(type:optionalErrorType, data: nil, error: resError, errorMessage: resError.localizedDescription)
            }
            else //if there is no nsError
            {
                return ResponseMetadata.getError(optionalErrorType)
            }
        }
    }
    //Function to set data from response to perform soft or force upgrade.
    func handleUpgradeData(_ json:JSON,errorCode:Int){
        //        let upgradeHandler = UpgradeHandler()
        //        let message = json[BeldaraRestClient.ERROR_MESSAGE_KEY].stringValue
        //        let imageUrl = json[BeldaraRestClient.ERROR_IMAGE_URL].stringValue
        //        upgradeHandler.handleUpdate(errorCode, message: message, imageUrl: imageUrl)
    }
    
    //Func to construct urlRequest from param and endpoint.
    func setUpApiURL(_ urlEndPoint:String,method:Alamofire.HTTPMethod,parameters : [String : AnyObject]) -> String {
        let apiUrl = FinmartRestClient.baseURLString + urlEndPoint
        /*let URLT = URL(string: apiUrl)!
         let URLRequest = NSMutableURLRequest(url: URLT)
         if BeldaraRestClient.shouldIgnoreCacheData{
         //URLRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
         URLRequest.cachePolicy = URLRequest.cachePolicy.reloadIgnoringLocalAndRemoteCacheData
         }
         URLRequest.httpMethod = method.rawValue
         let encoding = Alamofire.ParameterEncoding.url
         let urlRequest = encoding.encode(URLRequest, parameters: parameters).0*/
        return apiUrl
    }
    
    func setUpServiceApiURL(_ urlEndPoint:String,method:Alamofire.HTTPMethod,parameters : [String : AnyObject]) -> String {
        let apiUrl = FinmartRestClient.baseServiceURLString + urlEndPoint
        /*let URLT = URL(string: apiUrl)!
         let URLRequest = NSMutableURLRequest(url: URLT)
         if BeldaraRestClient.shouldIgnoreCacheData{
         //URLRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
         URLRequest.cachePolicy = URLRequest.cachePolicy.reloadIgnoringLocalAndRemoteCacheData
         }
         URLRequest.httpMethod = method.rawValue
         let encoding = Alamofire.ParameterEncoding.url
         let urlRequest = encoding.encode(URLRequest, parameters: parameters).0*/
        return apiUrl
    }
    
    func setUpERPApiURL(_ urlEndPoint:String,method:Alamofire.HTTPMethod,parameters : [String : AnyObject]) -> String {
        let apiUrl = FinmartRestClient.baseEncryptedErpIdURLString + urlEndPoint
        /*let URLT = URL(string: apiUrl)!
         let URLRequest = NSMutableURLRequest(url: URLT)
         if BeldaraRestClient.shouldIgnoreCacheData{
         //URLRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
         URLRequest.cachePolicy = URLRequest.cachePolicy.reloadIgnoringLocalAndRemoteCacheData
         }
         URLRequest.httpMethod = method.rawValue
         let encoding = Alamofire.ParameterEncoding.url
         let urlRequest = encoding.encode(URLRequest, parameters: parameters).0*/
        return apiUrl
    }
    
    func setUploanLeadURL(_ urlEndPoint:String,method:Alamofire.HTTPMethod,parameters : [String : AnyObject]) -> String {
        let apiUrl = FinmartRestClient.basegenerateloanLeadURLString + urlEndPoint
        /*let URLT = URL(string: apiUrl)!
         let URLRequest = NSMutableURLRequest(url: URLT)
         if BeldaraRestClient.shouldIgnoreCacheData{
         //URLRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
         URLRequest.cachePolicy = URLRequest.cachePolicy.reloadIgnoringLocalAndRemoteCacheData
         }
         URLRequest.httpMethod = method.rawValue
         let encoding = Alamofire.ParameterEncoding.url
         let urlRequest = encoding.encode(URLRequest, parameters: parameters).0*/
        return apiUrl
    }
    
    func sethealthAssureURL(_ urlEndPoint:String,method:Alamofire.HTTPMethod,parameters : [String : Any]) -> String {
        let apiUrl = FinmartRestClient.basehealthassureURLString + urlEndPoint
        /*let URLT = URL(string: apiUrl)!
         let URLRequest = NSMutableURLRequest(url: URLT)
         if BeldaraRestClient.shouldIgnoreCacheData{
         //URLRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
         URLRequest.cachePolicy = URLRequest.cachePolicy.reloadIgnoringLocalAndRemoteCacheData
         }
         URLRequest.httpMethod = method.rawValue
         let encoding = Alamofire.ParameterEncoding.url
         let urlRequest = encoding.encode(URLRequest, parameters: parameters).0*/
        return apiUrl
    }
    
    func handleExpiredCredentialError(_ error:ResponseMetadata){
        //NykaaActions.displaylogoutActionAlert(error)
    }
}

extension UIApplication {
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
        return "v\(version)(\(build))"
    }
}
