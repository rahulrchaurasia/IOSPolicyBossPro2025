//
//  LocationAttendance.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 08/05/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

// Used  KeyChain dependency : https://github.com/kishikawakatsumi/KeychainAccess

import SwiftUI
import CoreLocation
import TTGSnackbar
import KeychainAccess

struct LocationAttendanceView: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    @State var txtSearch : String = ""
    @StateObject var locationViewModel = LocationViewModel()
    
    @State private var isDataVisible = false
   
    
       @State private var isSnackbarVisible: Bool = false
    enum LoadingState {
        
        case none,loading, success, failed
    }
   // @State var loadingState = LoadingState.none
    //var  pbAttendResponse : PbAttendResponse?
    
    var pbListEntity =  [
        AttendanceEntity( Log_Date: "-23233", Log_Time: "12.40"),
        AttendanceEntity( Log_Date: "-23233", Log_Time: "12.40"),
        AttendanceEntity( Log_Date: "-23233", Log_Time: "12.40")
    ]
    
    var body: some View {
      
        ScrollView {
           
            VStack(alignment: .leading, spacing: 20)
            {
                
                //Mark: For Header Title
                HStack(spacing: 0){
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                        
                    }
                label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 24))
                    
                        .frame(width: 60, height: 40)
                        .foregroundColor(.blue)
                }.padding(.leading, 15)
                    
                    Text("PB Attendance")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }.padding(.leading, -20)
                
                //Mark: For Get Location Button
                VStack(alignment: .leading , spacing: 15) {
                    Button {
                        getLocationButtonClick()
                    } label: {
                        Text("Get My Current Location")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .font(.system(size: 17))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.accentColor
                            )
                            .cornerRadius(15)
                    }
                    
                    if isDataVisible {
                        //Text(viewModel.data ?? "")
                        
                        VStack{
                            Text("Latitude:  \(locationViewModel.locationLatText)")
                            
                            Text("Longitude:  \(locationViewModel.locationLonText)")
                        }
                        .opacity(isDataVisible ? 1 : 0)
                        .onAppear(){
                            withAnimation(.easeInOut) {
                                // Animation duration and timing function
                            }
                        }
                        
                        
                        
                        
                        
                    }
                    
                }
                
                .frame(maxWidth: .infinity)
                .padding(25)
                .background(.gray.opacity(0.2))
                .clipShape(
                    
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                    
                )
                // **** end here /////////
                
                
                
                Divider()
                    .background(Color.accentColor)
                
                ScrollView {
                    LazyVStack {
                        //Mark: Submit Button
                        if(isDataVisible && (!locationViewModel.locationLatText.isEmpty)){
                            
                            
                            // After getting the location Stop location
                            //locationViewModel.stopUpdatingLocatilocationManager.stopUpdatingLocation()
                            
                            Button {
                                saveButtonClick()
                            } label: {
                                Text("Submit Attendance")
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .font(.system(size: 17))
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        Color.green
                                    )
                                    .cornerRadius(15)
                                    .padding(.horizontal, 20)
                            }
                            //                            if loadingState == .loading {
                            //                                Text("Loading...")
                            //                            } else if loadingState == .success {
                            //                                Text("Success...")
                            //                            } else if loadingState == .failed {
                            //                                Text("Failed...")
                            //                            }
                        }
                        
                        
                    }
                    
                    ZStack {
                        Rectangle()
                        
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .opacity(0.8)
                            .cornerRadius(5)
                        
                        Text("Attendance History")
                            .foregroundColor(.white)
                            .font(.title2)
                    } .frame(maxWidth: .infinity)
                    
                    HStack{
                        
                        Text("Date")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Spacer(minLength: 10)
                        
                        Text("Entry Time")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        
                    }.padding(.horizontal,16)
                    //Mark: For List of Attendance
                    if let attendData = locationViewModel.attendanceResp{
                        
                        
                        if(!attendData.Details.isEmpty){
                            
                            VStack(alignment: .center, spacing: 8) {
                                
                                //pbListEntity
                                ForEach(attendData.Details, id: \.self) { entity in
                                    
                                    AttendanceCardView(attendanceEntity: entity)
                                    
                                }
                                
                            }
                        }
                        
                    }else{
                        
                        // Text("Loading...")
                    }
                    
                    
                    Spacer()
                    
                }// 05 scrollview
                
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Optional: Set the frame to occupy the available space
                .padding(.horizontal,8)
                .padding(.bottom,8)
                // Optional: Apply padding to the VStack
                
                
                .alert(isPresented:  $locationViewModel.showAlert) {
                    // Alert(title: Text("There was an error ") )
                    
                    Alert(title: Text("Location access is need to get your current Location"),
                          message: Text("Please Allow Location Access"),
                          primaryButton: .default( Text("OK"),
                                                   action: {
                        
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            
                            locationViewModel.showAlert = false
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                        }
                        
                        
                    }),
                          
                          secondaryButton : .destructive(Text("Cancel"))
                          
                    )
                }
                
                
                
                //}
                
                //.navigationTitle("")
                //                        .overlay(
                //                                    SnackbarView(
                //                                        message: "This is a snackbar!",
                //                                        actionTitle: "Dismiss",
                //                                        actionHandler: {
                //                                            // Handle action button tap
                //                                            print("Snackbar action tapped")
                //                                        },
                //                                        isShowing: $locationViewModel.showAlert
                //                                    )
                //
                //
                //
                //                            )
                .padding(.bottom, 0) // Adjust the spacing as needed
                
                .onAppear() {
                    isDataVisible = false
                    
                }
                .onDisappear {
                    locationViewModel.stopUpdatingLocation()
                }
            }
            
        }
      
    }
    
    func getLocationButtonClick(){
         
        print("Done")
       // locationViewModel.fetchLocation()
        
        locationViewModel.checkLocationService()
        DispatchQueue.main.async {
            withAnimation {
                isDataVisible = true
            }
        }
    }
    
   
   
    
    func showSnackbar() {
          let snackbar = TTGSnackbar(message: "Hello, TTGSnackbar!", duration: .middle)
          snackbar.actionText = "Dismiss"
          snackbar.actionBlock = {
              (snackbar: TTGSnackbar) in // Add explicit type annotation here
              snackbar.dismiss()
              // Perform action here
              print("Snackbar dismissed and action performed")
          }
          snackbar.show()
      }
     func saveButtonClick(){
        
        locationViewModel.checkLocationService()
         
        print("SAVE ACTION :-- Location Triggerd Again For Fresh Location ")
        Task {
            do {
      
                try await locationViewModel.getAttendance(lat: locationViewModel.locationLatText, lon: locationViewModel.locationLonText)
                
                               
                
            }
            catch {
            

                DispatchQueue.main.async {
//                    let snackbar = TTGSnackbar(message: Constant.errorMessage, duration: .middle)
//                    snackbar.show()
                    
                    showSnackbar()
                    
                }
                
//                DispatchQueue.main.async {
//

//
//                }
               
            }
       }
        
    }
    
  
    
}

struct LocationAttendance_Previews: PreviewProvider {
    static var previews: some View {
        LocationAttendanceView()
    }
}
