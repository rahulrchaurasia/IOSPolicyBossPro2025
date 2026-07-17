//
//  PBNotificationService.swift
//  policyBoss
//
//  Created by Rahul Chaurasia on 17/07/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//

import Foundation


import UserNotifications
import UIKit


//**********************************************************************/
//Note : Notification BigImage Handling
//**********************************************************************/



import UserNotifications
import UIKit

class PBNotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent else { return }
        
        // 1. Extract your custom parameter 'img_url' from the userInfo payload dictionary
        if let imgUrlString = bestAttemptContent.userInfo["img_url"] as? String,
           let attachmentURL = URL(string: imgUrlString) {
            
            // 2. Download the image file asynchronously to a temporary directory
            downloadAttachment(from: attachmentURL) { [weak self] localURL in
                guard let self = self else { return }
                
                if let localURL = localURL {
                    do {
                        // 3. Create the attachment block and assign it to the mutable payload content arrays
                        let attachment = try UNNotificationAttachment(identifier: "big_picture_attachment", url: localURL, options: nil)
                        bestAttemptContent.attachments = [attachment]
                    } catch {
                        print("FCM Extension Error creating attachment: \(error.localizedDescription)")
                    }
                }
                
                // Hand the modified content back to the OS system tray
                contentHandler(bestAttemptContent)
            }
        } else {
            // No valid image fallback pattern
            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        // Called by the system when download takes too long (max 30 seconds)
        // Deliver your best attempt content immediately to prevent drop packets
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    // MARK: - Networking Helper Methods
    private func downloadAttachment(from url: URL, completion: @escaping (URL?) -> Void) {
        let session = URLSession(configuration: .default)
        
        // Strictly set operational limits to mirror your Android connect/read parameters
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15.0)
        
        let downloadTask = session.downloadTask(with: request) { temporaryFileLocation, response, error in
            guard let temporaryFileLocation = temporaryFileLocation, error == nil else {
                completion(nil)
                return
            }
            
            // iOS attachments require specific system file location permissions.
            // Move the downloaded asset file out of the sandbox cache container to target local spaces.
            let fileManager = FileManager.default
            let temporaryDirectory = URL(fileURLWithPath: NSTemporaryDirectory())
            
            // Append file extension type explicitly based on response data path if available, defaulting to jpg
            let localDestinationURL = temporaryDirectory.appendingPathComponent(url.lastPathComponent)
            
            // Clean out pre-existing target components if necessary
            try? fileManager.removeItem(at: localDestinationURL)
            
            do {
                try fileManager.moveItem(at: temporaryFileLocation, to: localDestinationURL)
                completion(localDestinationURL)
            } catch {
                print("FCM Storage Module Write File Execution Failure: \(error.localizedDescription)")
                completion(nil)
            }
        }
        downloadTask.resume()
    }
}
