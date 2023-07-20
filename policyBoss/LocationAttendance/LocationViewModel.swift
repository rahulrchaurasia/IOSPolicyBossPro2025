//
//  LocationViewModel.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 08/05/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import Foundation

import CoreLocation
import UIKit
import KeychainAccess

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var locationText : String? 
    @Published var locationLatText : String = String()
    @Published var locationLonText : String = String()
    @Published var showLatLon = false
    @Published var showAlert = false
    
   // @Published var data: [MyData] = []     // For Publishing Array Data
    
    @Published var attendanceListData: [AttendanceEntity] = []
    
    @Published var attendanceResp : PbAttendResponse?
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation() // Start location updates
    }
    
//    func requestLocation() {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    
//           locationManager.requestWhenInUseAuthorization()
//           locationManager.startUpdatingLocation() // Start location updates
//       }
    
//    func fetchLocation() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.requestLocation()
//        case .denied:
//            locationText = "Location permission denied"
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            locationText = "Location access restricted"
//        default:
//            break
//        }
//    }
    
    
    func checkLocationService()  {
        
        DispatchQueue.global().async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                
               // showLatLon = false
                self.CheckLoocationAuthorization()
            }else {
                
                
            
                showAlert = true
            }
        }
        
    }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
//        locationText = "Latitude: \(userLocation.coordinate.latitude), Longitude: \(userLocation.coordinate.longitude)"
        
    
        locationLatText = "\(userLocation.coordinate.latitude)"
        locationLonText = "\(userLocation.coordinate.longitude)"
        
       // objectWillChange.send()
//        if locationLatText.isEmpty || (!showLatLon) {
//
//            locationLatText = "\(userLocation.coordinate.latitude)"
//            locationLonText = "\(userLocation.coordinate.longitude)"
//
//            showLatLon = true
//
//            //stopUpdatingLocation()
//        }
        
    }
    
    
    // Not in Used
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       // locationText = "Error getting location"
    }
    
    /*
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = manager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            locationText = "Location permission denied"
        case .notDetermined:
            break
        case .restricted:
            locationText = "Location access restricted"
        default:
            break
        }
    }
    */
    
    // end not in Used
    
    func CheckLoocationAuthorization(){
        
        switch(locationManager.authorizationStatus) {
            
        case .notDetermined:
            print("Statuds : notDetermined")
            // Ask for Authorization from user
            self.locationManager.requestWhenInUseAuthorization()
            
            break
        case .restricted, .denied:
            print("Statuds : restricted")
           
            
            DispatchQueue.main.async {
                self.showAlert = true
                
            }
           
            break
        
        case .authorizedWhenInUse, .authorizedAlways:
            print("Statuds : authorizedWhenInUse")
            startUpdatingLocation()
            break
        @unknown default:
            print("Statuds : Unknown")
            break
        }
    }
    
    func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }

        func stopUpdatingLocation() {
            locationManager.stopUpdatingLocation()
        }
    
    
    
    
    
    // For Text Json sample
    func test(){
        
        
//               let requestBody = """
//               {
//                   "title": "New Post",
//                   "body": "This is the content of the new post.",
//                   "userId": 1
//               }
//               """
//               request.httpBody = requestBody.data(using: .utf8)
//
//        request.httpBody = requestBody.data(using: .utf8)
   
    }
    
    func  getDeviceInKeyChain() -> String{
        
        
        let keychain  = Keychain(service: Constant.PbKeychain)
        
       // keyChainData = keychain["HighScore"] ?? "No Data"
        
        print("KeyStore Data get",keychain[string : Constant.DeviceDetail] ?? "No Data")
        
        return keychain[string : Constant.DeviceDetail] ?? ""
        
    }
    //************* Attendance Api Call *************
    func getAttendance(lat : String , lon : String) async throws  {
        
       
        guard let url = URL(string: Constant.PbAttendanceURL) else { fatalError("Missing URL") }
        
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               
               // Set the required headers
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               
        guard let userid = UserDefaults.standard.string(forKey: "userid")
        else{ return }
        
        guard let fullName =  UserDefaults.standard.string(forKey: "FullName")
        else{ return}
        
       
        // Create the request body
        let pbAttendanceReq = PbAttendRequestModel(
              DeviceId: getDeviceInKeyChain(),
              UID: userid,
              key: Constant.PbAttendanceKEY,
              lat: lat,
              lng: lon,
              name: fullName)

        do {
            let jsonReq = try JSONEncoder().encode(pbAttendanceReq)
            debugPrint("Request:-", pbAttendanceReq)
            request.httpBody = jsonReq
        } catch {
            print("Request Error :-",error.localizedDescription)
        }

        
        debugPrint("URL :-", Constant.PbAttendanceURL)
             
        let (data, response) = try await URLSession.shared.data(for: request)

        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let pbattendResp = try JSONDecoder().decode(PbAttendResponse.self, from: data)
        
        DispatchQueue.main.async {
            
            self.attendanceResp = pbattendResp
            

        }
     
    
       
        print("*****Async Respone******", pbattendResp)
        
       
    }
  
}


// MARK: - Welcome
struct Food: Codable {
    let id: Int
    let uid, dish, description, ingredient: String
    let measurement: String
}

// MARK: - PbAttendRequestModel
struct PbAttendRequestModel: Encodable  {
    let DeviceId, UID, key, lat: String
    let lng, name: String


}

///***************** Attendance Response Mesasge  ***************** //////////


// MARK: - PbAttendResponse
struct PbAttendResponse: Codable {
    //var id = UUID().uuidString
    let Status, message: String
    let Details: [AttendanceEntity]

    
}

// MARK: - Detail
struct AttendanceEntity: Hashable, Codable {
   
    let Log_Date, Log_Time: String

    
}

//struct IdentifiedAttendanceEntity: Identifiable {
//    let id = UUID()
//    let Log_Date, Log_Time: String
//
//}
