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

enum APIErrorDemo: Error {
    case statusCode(Int)
    case unknownResponse
    case decodingError(Error)
    case custom(message : String)
    
    var localizedDescription: String {
        switch self {
        case .statusCode(let code):
            return "API request failed with status code: \(code)"
        case .unknownResponse:
            return "Unknown response received from API"
        case .decodingError(let error):
            return "Error decoding data: \(error.localizedDescription)"
        case .custom(message: let message):
            return "\(message)"
        }
    }
}

enum APIError: Error {
       case invalidURL
        case noData
//        case invalidResponse
//        case clientError(statusCode: Int)
//        case serverError(message: String)
//        case decodingError(message: String)
//        case unexpectedStatusCode(code: Int)
    
        
        case networkError(error: Error)
        case decodingError(error: Error)
        case serverError(statusCode: Int, message: String?)
        case unexpectedResponse
        case unexpectedError(error: Error)
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
    
        // Helper function to extract server message from API response
        //let serverMessage = try? parseServerMessage(from: data)
        func parseServerMessage(from data: Data,msg: String) throws -> String? {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let message = json[msg] as? String {
                return message
            } else {
                return nil
            }
        }
    
    
//    static func handleAPIResponse<T: Decodable>(data: Data?, response: URLResponse?, responseType: T.Type) -> Result<T, APIError> {
//            do {
//                // Ensure response is an HTTPURLResponse before proceeding
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw APIError.invalidResponse
//                    
//                }
//
//                switch httpResponse.statusCode {
//                case 200: // Success
//                    guard let data = data else {
//                        throw APIError.noData
//                    }
//                    // Process successful response data
//                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
//                    return .success(decodedResponse)
//
//                case 400...499: // Client errors
//                    // Handle specific client errors (e.g., 401 for unauthorized access, 404 for not found)
//                    throw APIError.clientError(statusCode: httpResponse.statusCode)
//
//                case 500...599: // Server errors
//                    // Handle server errors (e.g., 500 for internal server error, 503 for service unavailable)
//                    throw APIError.serverError(message: "Server error occurred")
//
//                default: // Unexpected status codes
//                    throw APIError.unexpectedStatusCode(code: httpResponse.statusCode)
//                }
//            } catch {
//                return .failure(.decodingError(message: error.localizedDescription))
//            }
//        }
    
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
