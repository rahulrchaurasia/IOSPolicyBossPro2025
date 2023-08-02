//
//  registerViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 01/08/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation


final class registerViewModel {
    
    static let shareInstance = registerViewModel()
    
    private init (){}
    
    
    func getempbyregsource(campaignid : String) async throws -> (
    
        response : EmpbyregsourceResponse? , status : Int
    ){
        
        let endUrl = "/quote/Postfm/getempbyregsource"
        let urlString =  Configuration.baseROOTURL  + endUrl
        
        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
       
        // Set the "token" header
        let tokenValue = "1234567890"
      
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(tokenValue, forHTTPHeaderField: "token")
        debugPrint("URL :-", urlString)
        

        let apiReq: [String: Any] = [
                "appTypeId": "4",
                "campaignid": campaignid ,
                
            ]
        
        
        do {
               let jsonData = try JSONSerialization.data(withJSONObject: apiReq)
               debugPrint("Request:-", jsonData)
               request.httpBody = jsonData
           } catch {
               print(error.localizedDescription)
           }
        
        
        let (data,_) =  try await URLSession.shared.data(for: request,delegate: nil)
        
        let EmpbyregsourceResp = try JSONDecoder().decode(EmpbyregsourceResponse.self, from: data)
        
        
        
        return(EmpbyregsourceResp, EmpbyregsourceResp.StatusNo)
    }
    
}
