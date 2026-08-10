//
//  BranchCustomEvents.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 04/08/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//


//
//  BranchAnalyticsHelper.swift
//  MagicFinmart
//



import Foundation
import BranchSDK

// =========================================================================
// MARK: - Branch Custom Event Constants (Mirrors BranchCustomEvents.kt)
// =========================================================================
struct BranchCustomEvents {
    // Onboarding
    static let TUTORIAL_BEGIN = "Welcome_Screen"

    // Core Actions
    static let RAISE_TICKET_CLICKED = "Raise_Ticket_Clicked"
    static let CONTACT_SYNC_VIEWED = "Contact_Sync_Viewed"
    static let PRODUCT_SHARE = "Product_Share"
    static let SYNC_CONTACTS_VIEWED = "Sync_Contacts_Viewed"
    
    // Web Views
    static let PAGE_VIEW_WEBVIEW = "Common_WebView"

    // Resources
    static let SALESMATERIAL_VIEWED = "SalesMaterial_Viewed"

    // System & Navigation
    static let SCREEN_VIEW = "Screen_View"
    static let NOTIFICATION_RECEIVE = "Notification_Receive"
    static let NOTIFICATION_CLICK = "Notification_Click"
    static let DEEPLINK_CLICK = "Deeplink_Click"
    static let USER_LOGOUT = "User_Logout"
    static let APP_OPEN = "app_open_loggin_status"
}

// =========================================================================
// MARK: - Branch Analytics Helper (Mirrors AnalyticsBranchIOHelper.kt)
// =========================================================================
class BranchAnalyticsHelper {

    static let shared = BranchAnalyticsHelper()

    private let KEY_APP_VERSION = "app_version"
    private let KEY_SCREEN_NAME = "screen_name"

    private init() {}

    /**
     * Set the User Identity on Login using SSID.
     * Links all subsequent events to this specific user in the Branch dashboard.
     */
    func setIdentity(ssid: String?) {
        guard let ssid = ssid, !ssid.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, ssid != "0" else {
            print("BranchAnalytics: Attempted to set Branch Identity with invalid SSID: \(ssid ?? "nil")")
            return
        }
        Branch.getInstance().setIdentity(ssid)
        print("BranchAnalytics: Identity set for SSID: \(ssid)")
    }

    /**
     * Clear Identity on Logout.
     * Prevents the next user on this device from inheriting previous user events.
     */
    func clearIdentity() {
        Branch.getInstance().logout()
        print("BranchAnalytics: Identity cleared on logout")
    }

    /**
     * 1. TRACK STANDARD EVENTS (e.g., .viewItem, .search, .purchase)
     */
    func trackStandardEvent(
        eventType: BranchStandardEvent,
        screenName: String? = nil,
        alias: String? = nil,
        description: String? = nil,
        customData: [String: String]? = nil
    ) {
        let branchEvent = BranchEvent.standardEvent(eventType)
        buildAndLogEvent(
            branchEvent: branchEvent,
            eventNameString: "Standard_Event", // Passed for the print statement
            screenName: screenName,
            alias: alias,
            description: description,
            customData: customData
        )
    }

    /**
     * 2. TRACK CUSTOM EVENTS (e.g., "TUTORIAL_BEGIN", "Raise_Ticket_Clicked")
     */
    func trackCustomEvent(
        eventName: String,
        screenName: String? = nil,
        alias: String? = nil,
        description: String? = nil,
        customData: [String: String]? = nil
    ) {
        let branchEvent = BranchEvent.customEvent(withName: eventName)
        buildAndLogEvent(
            branchEvent: branchEvent,
            eventNameString: eventName, // Passed for the print statement
            screenName: screenName,
            alias: alias,
            description: description,
            customData: customData
        )
    }

    /**
     * PRIVATE CORE BUILDER
     * Automatically injects global parameters (like App Version) into every event.
     */
    private func buildAndLogEvent(
        branchEvent: BranchEvent,
        eventNameString: String,
        screenName: String?,
        alias: String?,
        description: String?,
        customData: [String: String]?
    ) {
        // 1. Add Global Properties
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        branchEvent.customData[KEY_APP_VERSION] = appVersion

        // 2. Add Common Optional Properties
        if let screenName = screenName {
            branchEvent.customData[KEY_SCREEN_NAME] = screenName
        }
        if let alias = alias {
            branchEvent.alias = alias
        }
        if let description = description {
            branchEvent.eventDescription = description
        }

        // 3. Add Specific Custom Data
        if let customData = customData {
            for (key, value) in customData {
                branchEvent.customData[key] = value
            }
        }

        // 4. Log Event
        branchEvent.logEvent()
        
        // Fix: Used the injected `eventNameString` instead of `branchEvent.eventName`
        print("BranchAnalytics: Event Logged -> \(eventNameString) | Screen: \(screenName ?? "N/A") | Data: \(customData ?? [:])")
    }
}
