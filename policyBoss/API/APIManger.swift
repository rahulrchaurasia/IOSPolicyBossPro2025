//
//  APIManger.swift
//  policyBoss
//
//  Created by Daniyal Shaikh on 05/07/21.
//  Copyright © 2021 policyBoss. All rights reserved.
//

import Foundation
import  Alamofire

enum APIErrors : Error {
    
    case custom(message : String)
    
              
}

typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void


class APIManger {


    static let shareInstance = APIManger()
       
       class func headers() -> HTTPHeaders
       {
           let headers: HTTPHeaders = [
               "Content-Type": "application/json",
                 "Accept": "application/json"
               ]
           
           return headers
       }
    
    
    //Mark : HealthAssure Module
    
    func getHealthAssureConfigure(completionHandler : @escaping Handler) {
        
       
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
                 
        let params: [String: AnyObject] = [ "FBAID": FBAId as AnyObject]
        
        

       
        let endUrl = "health-assure-configure"
        let url =  FinmartRestClient.baseURLString  + endUrl
        print("urlRequest= ",url)
        print("parameter= ",params)
        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
            
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                
                guard let data = response.data else { return }
                
                debugPrint(data)
                
                do {
                    
                    
                    let respData = try JSONDecoder().decode(HealthAssureConfigureResponse.self, from: data)
                    
                    
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message)))
                    }
                    
                    
                } catch let error {
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                    
                }
                
                
            case .failure(let error):
               completionHandler(.failure(.custom(message: error.localizedDescription)))
             
            }
        })
                 
        
    }
    
    
    
    
    //Mark : HealthAssure Module
    
    func getshortLink( strName : String ,completionHandler : @escaping Handler) {
        
       
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
       let phoneno = UserDefaults.standard.string(forKey: "MobiNumb1") ?? ""
                        

        let params: [String: AnyObject] = [ "fbaid": FBAId as AnyObject,
                                            "phoneno" : phoneno as AnyObject,
                                             "name" : strName as AnyObject]
         
       
        let endUrl = "short-url"
        let url =  FinmartRestClient.baseURLString  + endUrl
        print("urlRequest= ",url)
        print("parameter= ",params)
        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
            
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                
                guard let data = response.data else { return }
                
                debugPrint(data)
                
                do {
                    
                    
                    let respData = try JSONDecoder().decode(HealthAssureShortLinkResponse.self, from: data)
                    
                    
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message)))
                    }
                    
                    
                } catch let error {
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                    
                }
                
                
            case .failure(let error):
               completionHandler(.failure(.custom(message: error.localizedDescription)))
             
            }
        })
                 
        
    }
    
    /*************************************************************************/
    
    //Mark : Transaction History Module
    
    func getTransactionHistory( completionHandler : @escaping Handler) {
        
       
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
        let pageno = "1"

        let params: [String: AnyObject] = [ "fbaid": FBAId as AnyObject,
                                            "pageno" : pageno as AnyObject
                                            ]
         
       
        let endUrl = "get-transaction-history"
        let url =  FinmartRestClient.baseURLString  + endUrl
   
        print("urlRequest= ",url)
        print("parameter= ",params)
        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
            
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                
                guard let data = response.data else { return }
                
                debugPrint(data)
                
                do {
                    
                    
                    let respData = try JSONDecoder().decode(TransationHistoryResponse.self, from: data)
                    
                    
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message)))
                    }
                    
                    
                } catch let error {
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                    
                }
                
                
            case .failure(let error):
               completionHandler(.failure(.custom(message: error.localizedDescription)))
             
            }
        })
                 
        
    }
    
    
    //Mark : Transaction History Module
    
    func getNotificationList( completionHandler : @escaping Handler) {
        
       
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
  

        let params: [String: AnyObject] = [ "FBAID": FBAId as AnyObject]
         
       
        let endUrl = "get-notification-data"
        let url =  FinmartRestClient.baseURLString  + endUrl
   
        print("urlRequest= ",url)
        print("parameter= ",params)
        Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers: FinmartRestClient.headers).responseJSON(completionHandler: { (response) in
            
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                
                guard let data = response.data else { return }
                
                debugPrint(data)
                
                do {
                    
                    
                    let respData = try JSONDecoder().decode(NotificationResponse.self, from: data)
                    
                    
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message)))
                    }
                    
                    
                } catch let error {
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                    
                }
                
                
            case .failure(let error):
               completionHandler(.failure(.custom(message: error.localizedDescription)))
             
            }
        })
                 
        
    }
    
}
