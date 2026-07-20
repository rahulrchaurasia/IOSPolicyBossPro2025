//
//  NotificationService.swift
//  NotificationService
//
//  Created by Rahul Chaurasia on 20/07/26.
//  Copyright © 2026 policyBoss. All rights reserved.
//

import UserNotifications




class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {

        print("🚀 NotificationService Triggered")
        NSLog("🚀 NotificationService Triggered")

        self.contentHandler = contentHandler
        bestAttemptContent = request.content.mutableCopy() as? UNMutableNotificationContent

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        print("Payload = \(bestAttemptContent.userInfo)")

        guard
            let imageUrl = bestAttemptContent.userInfo["img_url"] as? String,
            let url = URL(string: imageUrl)
        else {
            print("No img_url found")
            contentHandler(bestAttemptContent)
            return
        }

        downloadImage(from: url) { localURL in

            if let localURL = localURL {

                do {

                    let attachment = try UNNotificationAttachment(
                        identifier: "image",
                        url: localURL,
                        options: nil
                    )

                    bestAttemptContent.attachments = [attachment]

                    print("✅ Attachment Added")

                } catch {

                    print(error)
                }
            }

            contentHandler(bestAttemptContent)
        }
    }

    override func serviceExtensionTimeWillExpire() {

        if let contentHandler = contentHandler,
           let bestAttemptContent = bestAttemptContent {

            contentHandler(bestAttemptContent)
        }
    }

    private func downloadImage(
        from url: URL,
        completion: @escaping (URL?) -> Void
    ) {

        URLSession.shared.downloadTask(with: url) { tempURL, _, error in

            guard
                let tempURL = tempURL,
                error == nil
            else {

                print("Download failed")

                completion(nil)

                return
            }

            let ext = url.pathExtension.isEmpty ? "jpg" : url.pathExtension

            let destination = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent(UUID().uuidString)
                .appendingPathExtension(ext)

            do {

                try FileManager.default.moveItem(
                    at: tempURL,
                    to: destination
                )

                completion(destination)

            } catch {

                completion(nil)
            }

        }.resume()
    }
}
