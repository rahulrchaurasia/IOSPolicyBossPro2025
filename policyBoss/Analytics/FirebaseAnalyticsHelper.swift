
import Foundation
import FirebaseAnalytics


protocol AnalyticsTracking {
    func trackEvent(_ eventName: String, parameters: [String: Any]?)
    func trackScreenView(screenName: String, className: String, extraParams: [String: Any]?)
    func setUserId(_ userId: String)
    func setUserProperty(name: String, value: String)
    func clearUserId()
}

class FirebaseAnalyticsHelper: AnalyticsTracking {
    
    // 1. Shared static instance (Singleton)
    static let shared: AnalyticsTracking = FirebaseAnalyticsHelper()
    
    // 2. Private init guarantees only ONE instance exists throughout the app lifetime
    private init() {
        
        
        Analytics.setDefaultEventParameters([
            "app_version": Configuration.appVersion
        ])
    }
    
    func trackEvent(_ eventName: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
    
    func trackScreenView(screenName: String, className: String, extraParams: [String: Any]? = nil) {
        var parameters: [String: Any] = [
            AnalyticsParameterScreenName: screenName,
            AnalyticsParameterScreenClass: className
        ]
        
        if let extraParams = extraParams {
            for (key, value) in extraParams {
                parameters[key] = value
            }
        }
        
        Analytics.logEvent(AnalyticsEventScreenView, parameters: parameters)
    }
    
    func setUserId(_ userId: String) {
        let trimmedId = userId.trimmingCharacters(in: .whitespaces)
        if !trimmedId.isEmpty && trimmedId != "0" {
            Analytics.setUserID(trimmedId)
        }
    }
    
    func setUserProperty(name: String, value: String) {
        Analytics.setUserProperty(value, forName: name)
    }
    
    func clearUserId() {
        Analytics.setUserID(nil)
    }
}
