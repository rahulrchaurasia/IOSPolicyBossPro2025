//
//  NotificationViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 24/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation


class NotificationViewModel{
    
    static let shareInstance = NotificationViewModel()
    
    func getNotificationData(completionHandler : @escaping Handler){
        
        let FBAId = UserDefaults.standard.string(forKey: "FBAId")
    
        let params: [String: AnyObject] = [ "FBAID": FBAId as AnyObject]
      

        let endUrl = "get-notification-data"
        let urlString =  FinmartRestClient.baseURLString  + endUrl
      
       
        
        
        //*******************************//
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
      
        debugPrint("URL :-", urlString)
        
        
        debugPrint("parameter= ",params)
        do {
            
        

            
           // let jsonReq = try JSONEncoder().encode(syncReqData)
            let requestBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request.httpBody = requestBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("token", forHTTPHeaderField: Constant.HeaderToken)
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        URLSession.shared.dataTask(with: request) { (  data, response, error) in
            
            if let error = error {
                completionHandler(.failure(.custom(message: error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completionHandler(.failure(.custom(message: serverError)))
                return
            }
            guard let data = data else {
                
                completionHandler(.failure(.custom(message: serverUnavailbleError)))
                return
            }
            
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                       // try to read out a string array
                        var Status = json["StatusNo"] as? Int ?? 1
                        print("STATUS" ,Status )
                           
                           if(Status  == 0){
                               let respData  = try
                               JSONDecoder().decode(NotificationResponse.self, from: data)
                               
                           
                               
                              // debugPrint("***RESPONSE****" , respData)
                               if respData.StatusNo == 0 {
                                  
                                   completionHandler(.success(respData))
                               }else{
                                   
                                   completionHandler(.failure(.custom(message: respData.Message )))
                               }
                           }
                           
                           else{
                               
                               completionHandler(.failure(.custom(message: json["Message"] as? String ?? Constant.NoDataFound)))
                           }
                       }
                    
                   
                
                
                
                
                //switch
                
                
            } catch let error {
                debugPrint("Error",error.localizedDescription)
                completionHandler(.failure(.custom(message: error.localizedDescription)))
            }
        }.resume()
    }
    

}

// MARK: - NotificationResponse
struct NotificationResponse: Codable {
    var Message : String
    var Status: String
    let StatusNo: Int
    let MasterData: [NotificationData?]

    
}

// MARK: - MasterDatum
struct NotificationData: Codable {
    let title : String?
    let  body, action: String?
    var img_url : String?
    let notifyFlag, web_url, web_title, is_read: String?
    let date: String?
    let message_id: Int?

 
}


