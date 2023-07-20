//
//  LocationAttendanceNew.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 09/06/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

// Used  KeyChain dependency : https://github.com/kishikawakatsumi/KeychainAccess

import SwiftUI
import CoreLocation
import TTGSnackbar
import KeychainAccess

struct LocationAttendanceNew: View {
    @State private var isLoading = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var txtSearch : String = ""
    @StateObject var locationViewModel = LocationViewModel()
    
    @State private var isDataVisible = true
    
    @State private var isSnackbarVisible: Bool = false
   
    
    @State private var loadingState: LoadingState = .none
    @State private var successMessage = ""
    
    private var textColor: Color {
        if ((locationViewModel.attendanceResp?.message.contains("successfully").description.uppercased()) != nil) {
               return .blue
           } else {
               return .red
           }
       }
    
    var loadingStateBinding: Binding<Bool> {
            Binding<Bool>(
                get: { loadingState == .loading },
                set: { newValue in
                    loadingState = newValue ? .loading : .none
                }
            )
        }
    
    var body: some View {
        
        ZStack{
            VStack {
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(.gray)
                    .frame(height: 0.1)
                
                
                //Mark: For Toolbar Title
                HStack(spacing: 0){
                    
                    Button {
                         presentationMode.wrappedValue.dismiss()
                        
                    }
                label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 28))
                    
                        .frame(width: 60, height: 50)
                        .foregroundColor(.white)
                }.padding(.leading, 15)
                    
                    Text("MY ATTENDANCE")
                    
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                .background(Color.accentColor)
                
                .padding(.leading, -20)
                
                // Mark For Location Button
                VStack(alignment: .center){
                    
                    Button {
                        getLocationButtonClick()
                    } label: {
                        Text("Get My Current Location")
                        
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal)
                            .background( Color.accentColor)
                            .cornerRadius(20)
                            .shadow(color: Color.accentColor.opacity(0.3), radius: 8, x: 5, y: 8)
                    }.padding(.top ,30)
                }
                
                Divider()
                
                
                VStack( alignment: .leading, spacing: 10){
                    
                    HStack{
                        
                        Text("Latitude:")
                        
                        Text(isDataVisible ? locationViewModel.locationLatText : "")
                            .fontWeight(.heavy)
                    }
                    
                    
                    HStack{
                        
                        Text("Longitude")
                        
                        Text(isDataVisible ? locationViewModel.locationLonText : "")
                            .fontWeight(.heavy)
                    }
                    
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading )
                .padding(.horizontal)
                
                if(isDataVisible && (!locationViewModel.locationLatText.isEmpty)){
                    
                    VStack(alignment: .center){
                         
                             Button {
                                 
                                 saveButtonClick()
                                
                             } label: {
                                 Text("Submit Attendance")
                                 
                                     .foregroundColor(.white)
                                     .font(.system(size: 16))
                                     .fontWeight(.semibold)
                                     .padding()
                                     .padding(.horizontal)
                                     .background( Color("greenDescent"))
                                     .cornerRadius(20)
                                     .shadow(color: Color.accentColor.opacity(0.3), radius: 8, x: 5, y: 8)
                             }
                         }
                                            
                    if loadingState == .success {
                        Text(locationViewModel.attendanceResp?.message ?? "")
                        
                            .font(.system(size: 19))
                            .fontWeight(.medium)
                            .foregroundColor(.blue.opacity(0.7))
                            .transition(.opacity)
                        
                    }else if loadingState == .fail {
                        
                        Text(Constant.errorMessage)
                        
                            .font(.system(size: 19))
                            .fontWeight(.medium)
                            .foregroundColor(.red.opacity(0.7))
                            .transition(.opacity)
                        
                    }else {
                       
                    }
                   
                       
                  
//                    if let attendData = locationViewModel.attendanceResp{
//
//
////                        if(!attendData.message.isEmpty){
////
////                            Text(attendData.message)
////
////                                .font(.system(size: 18))
////                                .fontWeight(.semibold)
////                                .foregroundColor(textColor)
////
////                        }
//
//                        if loadingState == .success {
//
//                            Text(attendData.message)
//
//                                .font(.system(size: 19))
//                                .fontWeight(.medium)
//                                .foregroundColor(.blue.opacity(0.7))
//
//                        }else if loadingState == .fail {
//
//                            Text(Constant.errorMessage)
//
//                                .font(.system(size: 19))
//                                .fontWeight(.medium)
//                                .foregroundColor(.red.opacity(0.7))
//
//                        }
//
//                    }
//
                    
                }
                // Mark For Submit Attendance Button
              
                
                VStack{
                    ZStack {
                        Rectangle()
                        
                            .frame(height: 50)
                            .foregroundColor(.gray)
                            .opacity(0.4)
                           
                        
                        Text("Attendance History")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
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
                }
              
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    VStack(alignment: .leading, spacing: 10){
                    
                        
                        Divider()
                        //Mark : List of Attendance
                        if let attendData = locationViewModel.attendanceResp{
                            
                            
                            if(!attendData.Details.isEmpty){
                                
                                VStack(alignment: .center, spacing: 8) {
                                    
                                    //pbListEntity
                                    ForEach(attendData.Details, id: \.self) { entity in
                                        
                                        AttendanceCardView(attendanceEntity: entity)
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        
                        Spacer()
                       
        
                    }
                    
                }
                
    //            .background(Color.primary)
    //            .cornerRadius(40)
    //            .offset(y:40)
                
              
                
                // Mark : Alert Dialog
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
                
                    .onAppear() {
                        isDataVisible = false
                        
                    }
                    .onDisappear {
                        locationViewModel.stopUpdatingLocation()
                    }
                    
              
            }
            CustomLoaderView(isLoading: loadingStateBinding)
        }
     
        
        
    }
    
    func getLocationButtonClick(){
        
      
        loadingState = .none
       
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
        
        loadingState = .loading
       
        locationViewModel.checkLocationService()
         
        print("SAVE ACTION :-- Location Triggerd Again For Fresh Location ")
        Task {
            do {
      
               
                try await locationViewModel.getAttendance(lat: locationViewModel.locationLatText, lon: locationViewModel.locationLonText)
                
                loadingState = .success
                
            }
            catch {
            

                DispatchQueue.main.async {
                    //isDataVisible = false
                    loadingState = .fail
                   // showSnackbar()
                    
                }
                

               
            }
       }
        
    }
    
  
}

struct LocationAttendanceNew_Previews: PreviewProvider {
    static var previews: some View {
        LocationAttendanceNew()
    }
}
