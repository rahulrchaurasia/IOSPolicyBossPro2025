//
//  SyncContactViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 23/03/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

class SyncContactViewModel{
    
    static let shareInstance = SyncContactViewModel()

    func fetchDataFromApi( subContactList : [ContactMainModel],rawData : String, completionHandler : @escaping Handler) {
        
        
        
        let urlString = String("\(Configuration.baseROOTURL)/sync_contacts/contact_entry")
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("URL :-", urlString)
        
        guard let FBAId = (UserDefaults.standard.string(forKey: "FBAId"))
        else{ return }
        
        guard let parentid = (UserDefaults.standard.string(forKey: "parentid"))
        else{ return }
        
        guard let ssid = (UserDefaults.standard.string(forKey: "POSPNo"))
        else{ return }
        
        var fbaid = ""
        var sub_fba_id = ""
        if (parentid.trimmingCharacters(in: .whitespacesAndNewlines) == "" || parentid == "0" ) {
            
            fbaid = FBAId
            sub_fba_id = parentid
            
        } else {
            fbaid = parentid
            sub_fba_id = FBAId
        }
        let syncReqData = SyncContactModelRequest(
            fbaid: fbaid,
            ssid: ssid,
            sub_fba_id: sub_fba_id,
            raw_data: rawData,
            contactlist: subContactList
        )
        do {
            let jsonReq = try JSONEncoder().encode(syncReqData)
            debugPrint("Request:-", syncReqData)
            request.httpBody = jsonReq
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
            
            debugPrint("***RESPONSE****" , data)
            
            do {
                
                let respData  = try
                JSONDecoder().decode(SyncContactResponse.self, from: data)
                
                
                if respData.StatusNo == 0 {
                    
                    completionHandler(.success(respData))
                }else{
                    
                    completionHandler(.failure(.custom(message: respData.Message ?? serverUnavailbleError)))
                }
                //switch
                
                
            } catch let error {
                debugPrint("Error",error.localizedDescription)
                completionHandler(.failure(APIErrors.custom(message: error.localizedDescription)))
            }
        }.resume()
        //}
        
        
    }
    
    func fetchDataFromApiNOTINUSED( subContactList : [ContactMainModel], completionHandler : @escaping Handler) {
        
       
        let urlString = String("https://horizon.policyboss.com:5443/sync_contacts/contact_entry")
                guard let url = URL(string: urlString) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            debugPrint("URL :-", urlString)
        
        let syncReqData = SyncContactModelRequest(
                    fbaid: "89435",
                    ssid: "119227",
                    sub_fba_id: "0",
                    raw_data: "",
                    contactlist: subContactList
                    )
                do {
                    let jsonReq = try JSONEncoder().encode(syncReqData)
                    debugPrint("Request:-", syncReqData)
                    request.httpBody = jsonReq
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
                
                debugPrint("***RESPONSE****" , data)
                
                do {
                   
                    let respData  = try
                       JSONDecoder().decode(SyncContactResponse.self, from: data)
                    
                   
                    if respData.StatusNo == 0 {
                        
                        completionHandler(.success(respData))
                    }else{
                        
                        completionHandler(.failure(.custom(message: respData.Message ?? serverUnavailbleError)))
                    }
                    //switch
                    
                    
                } catch let error {
                    debugPrint("Error",error.localizedDescription)
                    completionHandler(.failure(.custom(message: error.localizedDescription)))
                }
            }.resume()
        //}
            
        
    }
    
    
    func fetchSyncAgreement() async throws ->  (response: SyncContactAgreementResponse?,status : String ){

        
        guard let ssid = (UserDefaults.standard.string(forKey: "POSPNo"))
        else{
          throw APIErrors.custom(message: Constant.InvalidURL)
        }
        
        let endUrl = "/sync_contact/get_sync_contact_agreements?ss_id=" + ssid
        let urlString =  Configuration.baseROOTURL  + endUrl


        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("URL :-", urlString)
        
        
        // Use the async variant of URLSession to fetch data
          // Code might suspend here
        
        //let (data, _) = try await URLSession.shared.data(from: url) //For Default Get method {When not specified)
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        //Parse the JSON Data
        
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            // try to read out a string array
            var Status = json["Status"] as? String ?? "Fail"
            print("STATUS" ,Status )
            if(Status.lowercased()  == "success"){
                
                let syncAgreementResp = try JSONDecoder().decode(SyncContactAgreementResponse.self, from: data)
                
                
                
                return (syncAgreementResp, "0")
            }else{
                
                return (nil,"1")
            }
            
            
            
        }
        else{
            return (nil,"1")
        }
    }
    
    
    func saveSyncAgreement(isCall : Bool , isSMS : Bool) async throws ->  String{

       var strCall = "", strSMS = ""
        guard let FBAId = (UserDefaults.standard.string(forKey: "FBAId"))
        else{ return "Fail" }
        guard let ssid = (UserDefaults.standard.string(forKey: "POSPNo"))
        else{
            return "Fail"
        }
        
        let endUrl = "/postservicecall/sync_contacts/online_agreement"
        let urlString =  Configuration.baseROOTURL  + endUrl


        guard let url = URL(string: urlString) else {
            throw APIErrors.custom(message: Constant.InvalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        debugPrint("URL :-", urlString)
        
      
        let syncAgreementReq = SyncContactAgreementRequest(
            fba_id: Int(FBAId) ?? 0,
            is_call: isCall ? "yes": "no" ,
            is_sms: isSMS ? "yes": "no" ,
            online_agreement: "online_agreement",
            ss_id: Int(ssid) ?? 0)
        do {
            let jsonReq = try JSONEncoder().encode(syncAgreementReq)
            debugPrint("Request:-", syncAgreementReq)
            request.httpBody = jsonReq
        } catch {
            print(error.localizedDescription)
        }
        
       
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        //Parse the JSON Data
        
        let syncAgreementResp = try JSONDecoder().decode(SyncContactAgreementSaveResponse.self, from: data)
       
        
        
        return syncAgreementResp.Status
        
        
        
    }
    
}




