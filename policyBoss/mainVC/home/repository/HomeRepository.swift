//
//  HomeRepository.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation



actor HomeRepository : HomeRepositoryProtocol {
   
   
    
    

    
   private let apiService : APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    func fetchUserConstant(req: UserConstantRequest) async throws -> UserConstantResponse? {
        

        let urlString = Configuration.baseURLString + "user-constant-pb"
        
        guard let url = URL(string: urlString) else {
            throw APIError.custom(message: Constant.InvalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // ✅ Use only JSONEncoder for Encodable struct
        // For Normal Dict Used JSONSerialization
        request.httpBody = try JSONEncoder().encode(req)

        debugPrint("Request URL: \(urlString)")
        if let bodyString = String(data: request.httpBody ?? Data(), encoding: .utf8) {
                debugPrint("Request Body: \(bodyString)")
            }   

        let (data, response) = try await URLSession.shared.data(for: request)
        
       
        

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.custom(message: "Invalid server response")
        }

       
        //Parse the JSON Data
        
        let UserConstantResp = try? JSONDecoder().decode(UserConstantResponse.self, from: data)
       
        if(UserConstantResp?.Status.lowercased()  == "success"){
           
            // fetch Response
        
            
            return UserConstantResp
            
        }
        return nil
        
    }
    
    func getUserCallingDetail() async throws ->(result: UserCallingResponse?, status : String) {
       
        
        let appVersion = Configuration.appVersion
        let deviceID = Configuration.deviceID
        let FBAId = UserDefaultsManager.shared.getFbaId()
        let SSID = UserDefaultsManager.shared.getSsId()

        let params: [String: Any] = [
            "fbaid": FBAId,
            "ssid": SSID,
            "app_version": appVersion,
            "device_code": deviceID
        ]

        let urlString = Configuration.baseURLString2 + "user-calling"
        guard let url = URL(string: urlString) else {
            throw APIError.custom(message: Constant.InvalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try JSONSerialization.data(withJSONObject: params)
        request.httpBody = jsonData

        debugPrint("Request URL: \(urlString)")
        debugPrint("Request Body: \(String(data: jsonData, encoding: .utf8) ?? "")")

        let (data, response) = try await URLSession.shared.data(for: request)
        
       
        

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.custom(message: "Invalid server response")
        }

       
        //Parse the JSON Data
        
        let UserCallingResp = try? JSONDecoder().decode(UserCallingResponse.self, from: data)
       
        if(UserCallingResp?.Status.lowercased()  == "success"){
           
            // fetch Response
        
            
            return(UserCallingResp,"0")
            
        }
        return (nil,"1")
    }

    
    func fetchDynamicDashboard2(req: DynamicDashboardRequest) async throws -> DynamicDashboardResponse {
        
        try await apiService.request(
                    endpoint: "get-dynamic-app-pb",
                    method: .post,
                    urlType: .primary,
                    headers: nil,
                    body: req,
                    queryItems: nil
                )
    }
    
    
    func fetchDynamicDashboard(req: DynamicDashboardRequest) async throws -> DynamicDashboardResponse? {
        

        let urlString = Configuration.baseURLString + "get-dynamic-app-pb"
        
        guard let url = URL(string: urlString) else {
            throw APIError.custom(message: Constant.InvalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // ✅ Use only JSONEncoder for Encodable struct
        // For Normal Dict Used JSONSerialization
        request.httpBody = try JSONEncoder().encode(req)

        debugPrint("Request URL: \(urlString)")
        if let bodyString = String(data: request.httpBody ?? Data(), encoding: .utf8) {
                debugPrint("Request Body: \(bodyString)")
            }

        let (data, response) = try await URLSession.shared.data(for: request)
        
       
        

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.custom(message: "Invalid server response")
        }

       
        //Parse the JSON Data
        
        let dynamicResp = try? JSONDecoder().decode(DynamicDashboardResponse.self, from: data)
       
        if(dynamicResp?.Status.lowercased()  == "success"){
           
            // fetch Response
        
            debugPrint("Dynamic Dashboard fetched successfully\(String(describing: dynamicResp?.MasterData.Dashboard?.count ?? 0))")
            return dynamicResp
            
        }
        return nil
        
    }

    
    func sendDeviceDetails(req: DeviceDetailsRequest) async throws -> DeviceDetailsResponse {
        
        let strURL = "https://horizon.policyboss.com:5443/app_visitor/save_device_details"
        let response: DeviceDetailsResponse = try await apiService.request(
                    endpoint: "",
                    method: .post,
                    urlType: .custom(strURL),
                    headers: nil,
                    body: req,
                    queryItems: nil
                )
                if response.Status != "SUCCESS" {
                    print("⚠️ Device API response status: \(response.Status)")
                }
        
        return response
    }
    
    
    
    //For Contact Us
    
    func fetchContactUsData(req: ContactUsRequest) async throws -> ContactUsResponse? {
        guard let url = URL(string: "https://horizon.policyboss.com:5443/quote/Postfm/contact-us-PB") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(req)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let contactResp = try? JSONDecoder().decode(ContactUsResponse.self, from: data)
        
        
        return contactResp
    }
    
    
    func qrPreScanner(req: ScannerPreReq) async throws -> QRScannerResponse {
        
        let strURL = "https://horizon.policyboss.com:5443/logins/token-status"
        
        let response: QRScannerResponse =
        try await apiService.request(
                    endpoint: "",
                    method: .post,
                    urlType: .custom(strURL),
                    headers: nil,
                    body: req,
                    queryItems: nil
                )
                if response.Status != "SUCCESS" {
                    print("⚠️ Device API response status: \(response.Status)")
                }
        
        return response
    }
    
    func qrVerifyScanner(req: ScannerVerifiedReq) async throws -> QRScannerResponse {
        //logins/token-status
        
        let strURL = "https://horizon.policyboss.com:5443/logins/token-status"
        
        let response: QRScannerResponse =
        try await apiService.request(
            endpoint: "",
            method: .post,
            urlType: .custom(strURL),
            headers: nil,
            body: req,
            queryItems: nil
        )
        
        // ✅ Business validation
        guard response.Status
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
                .uppercased() == "SUCCESS"
        else {
            
            throw NetworkError.businessError(
                response.Msg
            )
        }
        
        
        return response
    }
    
   

}

