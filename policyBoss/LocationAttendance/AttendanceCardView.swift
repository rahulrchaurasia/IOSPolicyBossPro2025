//
//  AttendanceListView.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 16/05/23.
//  Copyright © 2023 policyBoss. All rights reserved.
//

import SwiftUI

struct AttendanceCardView: View {
    
    var attendanceEntity : AttendanceEntity
    var body: some View {
       
        VStack(alignment: .leading,spacing: 0){
           
            HStack{
                
                Text(attendanceEntity.Log_Date)
                    .font(.system(size: 16))
                Spacer(minLength: 10)
                
                Text(attendanceEntity.Log_Time)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.trailing,10)
                
            }
        }.padding(.all,4 )
        .padding(.horizontal,12)

        
        Divider()
      
        
    }
}

struct AttendanceCardView_Previews: PreviewProvider {
    static var previews: some View {
        let entity = AttendanceEntity(Log_Date: "2020.03.27", Log_Time: "19:26:22")
        AttendanceCardView(attendanceEntity: entity)
    }
}
