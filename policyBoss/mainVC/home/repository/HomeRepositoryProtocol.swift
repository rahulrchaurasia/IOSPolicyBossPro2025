//
//  HomeRepositoryProtocol.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 31/10/25.
//  Copyright © 2025 policyBoss. All rights reserved.
//

import Foundation

protocol HomeRepositoryProtocol {
    

    
    func fetchUserConstant(req: UserConstantRequest)  async throws -> UserConstantResponse?
    
    func fetchDynamicDashboard(req: DynamicDashboardRequest) async throws -> DynamicDashboardResponse?
    
    func sendDeviceDetails(req: DeviceDetailsRequest) async throws -> DeviceDetailsResponse
    
    ///
    func qrPreScanner(req: ScannerPreReq) async throws -> QRScannerResponse
    
    func qrVerifyScanner(req: ScannerVerifiedReq) async throws -> QRScannerResponse
    
    
    func fetchContactUsData(req: ContactUsRequest) async throws -> ContactUsResponse?
}
