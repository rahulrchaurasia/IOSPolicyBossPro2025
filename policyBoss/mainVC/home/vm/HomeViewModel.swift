//
//  HomeViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation
import UIKit

@MainActor
class HomeViewModel  : ObservableObject {
 
    @Published var isLoading = false
        @Published var errorMessage: String?
        
       @Published var allDataLoaded = false
    
        @Published var userConstant: UserConstantResponse?
        @Published var dynamicDashboard: DynamicDashboardResponse?
         @Published var deviceResponse: DeviceDetailsResponse?  // not Used
        
        private let repository: HomeRepository
    
      // var userDashboardModel = [UserConstDashboarddModel]()
    @Published var userDashboardModel : [UserConstDashboarddModel] = []
    @Published var dynamicDashboardModel: [DynamicDashboardModel] = []
    
    @Published var scannerState: ScannerLoginState = .idle
    
    //For Contact

    @Published var contactUsResponse: ContactUsResponse? = nil
    @Published var contactUsData: [ContactUsData] = []
    
    init(repository: HomeRepository) {
            self.repository = repository
        }
    
    func loadInitialData(sendDeviceDetails: Bool = true) async {
        
        isLoading = true
        
        defer{ isLoading = false }
        
        
        
        do {
           
        
            let FBAId = UserDefaults.standard.string(forKey: "FBAId") ?? "0"
            let appVersion = Configuration.appVersion
            let deviceID = Configuration.deviceID
                        
            let SSID = UserDefaultsManager.shared.getPOSPNo()
            
            print(FBAId,SSID)
                          
           // let ipAddress = NetworkManager.shared.getIPAddress() ?? ""

            // 🧩 Step 1: Call UserConstant first
            
            let userReq = UserConstantRequest (
                
                fbaid: FBAId,
                app_version: appVersion,
                ssid: SSID,
                device_code: deviceID
            )
            
            let userConstantResponse = try await repository.fetchUserConstant(req: userReq)
            print("userConstantResponse DONE")
            
            
            if let response = userConstantResponse {
                handleUserConstant(response)
                self.userConstant = userConstantResponse
            } else {
                print("UserConstantResponse is nil")
            }
          
            
            // 🧩 Step 2: Parallel API calls
            
            //a> make req
            let dynamicReq = DynamicDashboardRequest(
                fbaid: FBAId,
                app_version: appVersion,
                ssid: SSID,
                device_code:  deviceID
            )
            
            if let dynamicResponse = try await repository.fetchDynamicDashboard(req: dynamicReq) {
                handleDynamicDashboard(dynamicResponse)
            }
            
            // Step 3: Optional Device Details
            if sendDeviceDetails {
                let deviceReq  = DeviceDetailsRequest(
                    ss_id: SSID,
                    device_id: deviceID,
                    device_name: getDeviceName() ,
                    os_detail: getDeviceOS(),
                    action_type: "active",
                    device_info: "",
                    App_Version: appVersion
                )
                Task { _ = try? await repository.sendDeviceDetails(req: deviceReq) }
                
            }
            
//            // b> used async let for parallel call used below comented
//            async let dynamic  = repository.fetchDynamicDashboard(req: dynamicReq)
//            async let device   = repository.sendDeviceDetails(req: deviceReq)
//            
//
//           //c> call Parallel
//            let (dynamicResp, deviceResp) = try await (dynamic, device)
            
//            if let dynamicRespMain = dynamicResp {
//                handleDynamicDashboard(dynamicRespMain)
//                self.dynamicDashboard = dynamicRespMain
//            } else {
//                print("UserConstantResponse is nil")
//            }
//
            
         
            // Step 4: Mark all data done
            self.allDataLoaded = true
        }
        catch{
            self.allDataLoaded = false
            self.isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    
    
    // MARK: - Handle UserConstant
    
        func handleUserConstant(_ response: UserConstantResponse) {
            
            do {
                

                // Build dashboard models
                userDashboardModel = response.MasterData.dashboardarray?.map { item in
                    UserConstDashboarddModel(
                        ProdId: item.ProdId,
                        url: item.url
                    )
                } ?? []
                
                let master = response.MasterData
                
                print("Master Data: \(master)")
                
                // Save scalar values safely
                if let uid = master.uid { UserDefaults.standard.set(String(uid), forKey: "uid") }
                if let iosuid = master.iosuid { UserDefaults.standard.set(String(iosuid), forKey: "iosuid") }
                if let managName = master.ManagName {
                    UserDefaults.standard.set(managName, forKey: "ManagName")
                }
                if let mangEmail = master.MangEmail { UserDefaults.standard.set(mangEmail, forKey: "MangEmail") }
                if let mangMobile = master.MangMobile { UserDefaults.standard.set(mangMobile, forKey: "MangMobile") }
                if let suppEmail = master.SuppEmail { UserDefaults.standard.set(suppEmail, forKey: "SuppEmail") }
                if let suppMobile = master.SuppMobile { UserDefaults.standard.set(suppMobile, forKey: "SuppMobile") }
                
                // Optional URLs
                UserDefaultsManager.shared.setRaiseTicketURL(master.RaiseTickitUrl ?? "")
                UserDefaults.standard.set(master.TwoWheelerUrl ?? "", forKey: "TwoWheelerUrl")
                UserDefaults.standard.set(master.FourWheelerUrl ?? "", forKey: "FourWheelerUrl")
                UserDefaults.standard.set(master.healthurl ?? "", forKey: "healthurl")
                UserDefaults.standard.set(master.CVUrl ?? "", forKey: "CVUrl")
                UserDefaults.standard.set(master.notificationpopupurl ?? "", forKey: "notificationpopupurl")
                UserDefaults.standard.set(master.LeadDashUrl ?? "", forKey: "LeadDashUrl")
                UserDefaults.standard.set(master.iosversion ?? "", forKey: "iosversion")
                
                // Enable add sub-user URL
    //            UserDefaults.standard.set(master.enable_pro_Addsubuser_url ?? "", forKey: Constant.AddsubuserUrl)
                
                // POSP photo/designation
                if let pospPhoto = master.pospselfphoto { UserDefaultsManager.shared.savePospSelfPhoto(pospPhoto) }
                if let pospDesignation = master.pospselfdesignation { UserDefaultsManager.shared.savePospSelfDesignation(pospDesignation) }
                
            }catch {
                print("Encoding error: \(error)")
            }
            
           
        }
    
    
    
    
    
    func handleDynamicDashboard(_ response: DynamicDashboardResponse) {
        let subUserSsId = UserDefaultsManager.shared.getSubUserSsId() ?? "0"

        // Safely access MasterData.Dashboard
        let items = response.MasterData.Dashboard ?? []
        print("📥 Raw Dynamic Dashboard count:", items.count)

       

        // Filter + map safely to your model
        dynamicDashboardModel = items.compactMap { item in
            // require type == 1
            guard let type = item.dashboard_type, type == 1 else { return nil }
            // skip ProdId == 41 for sub-user
            if subUserSsId != "0", let pid = item.ProdId, pid == 41 { return nil }
            // map — uses extension toModel()
            return item.toModel()
        }

        print("✅ Final dynamicDashboardModel count:", dynamicDashboardModel.count)
    }

    //    func handleDynamicDashboard1(_ response : DynamicDashboardResponse){
    //
    //        let subUserSsId = UserDefaultsManager.shared.getSubUserSsId() ?? "0"
    //
    //        do {
    //            dynamicDashboardModel = response.Dashboard?
    //                .filter { item in
    //                    // Keep only dashboard_type == 1 and sub-user condition
    //                    if item.dashboard_type != 1 { return false }
    //                    if subUserSsId != "0" && String(item.ProdId) == "41" { return false }
    //                    return true
    //                }
    //                .map { item in
    //                    DynamicDashboardModel(
    //                        menuid: item.menuid,
    //                        menuname: item.menuname,
    //                        link: item.link ?? "",
    //
    //                        iconimage: item.iconimage,
    //                        isActive: item.isActive,
    //                        dashdescription: item.description,
    //
    //                        modalType: "INSURANCE",
    //                        dashboard_type: String(item.dashboard_type),
    //                        ProdId: String(item.ProdId),
    //
    //                        ProdName: item.menuname,
    //                        ProductNameFontColor: item.ProductNameFontColor ?? "",
    //                        ProductDetailsFontColor: item.ProductDetailsFontColor ?? "",
    //
    //                        ProductBackgroundColor: item.ProductBackgroundColor ?? "",
    //                        IsExclusive: item.IsExclusive ?? "",
    //                        IsNewprdClickable: item.IsNewprdClickable ?? "",
    //
    //                        IsSharable: item.IsSharable ?? "",
    //                        popupmsg: item.popupinfo ?? "",
    //                        title: item.title ?? "",
    //                        info: item.infourl ?? ""
    //                    )
    //                } ?? []
    //
    //        } catch {
    //            self.errorMessage = error.localizedDescription
    //        }
    //    }

    
    
    //contact Us
    
   
    
    func fetchContactUsData() async {
        
        isLoading = true
        
        defer{ isLoading = false }
        
        
        
        do {
           
        
            let FBAId = UserDefaults.standard.string(forKey: "FBAId") ?? "0"
            let appVersion = Configuration.appVersion
            let deviceID = Configuration.deviceID
                        
            let SSID = UserDefaultsManager.shared.getPOSPNo()
            
            let request = ContactUsRequest(
                        app_version: appVersion,
                        device_code: deviceID,
                        fbaid: FBAId,
                        ssid: SSID
                    )
            
            
            let userContactResponse = try await repository.fetchContactUsData(req: request)
           
            print("Contact Called DONE")
            
            
            if let response = userContactResponse {
               
                self.contactUsResponse = response
            } else {
                print("contactUsResponse is nil")
            }
          
            
        
        }
        catch{
            self.isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    
    func qrPreScanner(token: String) async  {
        
        do {

            let request = ScannerPreReq(status: "SCANNED",
                                        token_id: token,
                                        update_by: "token",
                                        secret_key: Constant.SECRET_KEY,
                                        client_key: Constant.CLIENT_KEY)

            let response = try await repository
                .qrPreScanner(req: request)

            print("QR RESPONSE:", response)

    

        } catch {

            print("QR RESPONSE:", error.localizedDescription)
        }
    }
    
    func qrVerifiedScanner(token: String) async -> ScannerLoginState {
        
        let SSID = UserDefaultsManager.shared.getPOSPNo()
        
        // ✅ UI UPDATE ON MAIN THREAD
        scannerState = .loading

        do {
            // fake api delay
          // try await Task.sleep(for: .seconds(5))
            
            let request = ScannerVerifiedReq(
                status: "VERIFIED",
                ss_id: SSID,
                token_id: token,
                update_by: "token",
                secret_key: Constant.SECRET_KEY,
                client_key: Constant.CLIENT_KEY
            )
            
           

            let response = try await repository
                .qrVerifyScanner(req: request)

            print("QR RESPONSE:", response)

            scannerState = .success(response.Msg)
            
           return scannerState
        } catch let error as NetworkError {
            
            let errorState =
            ScannerLoginState.error(
                error.localizedDescription
            )

            scannerState = errorState

            return errorState

        }catch {
            
            let errorState =
            ScannerLoginState.error(
                "Something went wrong"
            )

            scannerState = errorState

            return errorState
        }
    }
   
    func resetScannerState() {

        guard scannerState != .idle else {
               return
           }

           scannerState = .idle
       }
    func getDeviceName() -> String{
        

        // Get the device name
        return UIDevice.current.name

       
    }
    
    func getDeviceOS() -> String{
        

        // Get the device name
        return UIDevice.current.systemName + "" + UIDevice.current.systemVersion

       
    }
        
}
