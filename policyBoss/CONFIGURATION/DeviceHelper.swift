import UIKit

struct DeviceHelper {
    private static let deviceIdKey = "deviceID" // Key to store deviceId in UserDefaults
    
    // Static property to get or generate the deviceId
    static let deviceId: String = {
        let defaults = UserDefaults.standard
        
        // Check if a deviceId already exists in UserDefaults
        if let savedDeviceId = defaults.string(forKey: deviceIdKey) {
            return savedDeviceId
        }
        
        // Attempt to get identifierForVendor
        if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
            // Save the identifierForVendor in UserDefaults for future use
            defaults.set(vendorId, forKey: deviceIdKey)
            return vendorId
        }
        
        // Generate a new UUID if identifierForVendor is unavailable
        let newDeviceId = UUID().uuidString
        defaults.set(newDeviceId, forKey: deviceIdKey)
        return newDeviceId
    }()
}
