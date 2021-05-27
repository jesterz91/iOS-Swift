//
//  AppDelegate.swift
//  CloudMessage
//
//  Created by lee on 2021/05/27.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { granted, error in

        })

        application.registerForRemoteNotifications()

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /* 디바이스 토큰 등록 성공 */
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined() // Base16-encoded / hexadecimal string
        print("deviceToken : \(deviceTokenString)")

        // https://firebase.google.com/docs/cloud-messaging/ios/receive?authuser=0#handle_messages_with_method_swizzling_disabled
        // Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        // https://firebase.google.com/docs/cloud-messaging/ios/receive?authuser=0#handle_silent_push_notifications
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)

        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {

    /* 토큰 갱신 모니터링 */
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict :[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

        // sendToServer(fcmToken)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo
        print(userInfo)

        // To pass notification reciept information to Analytics,
        Messaging.messaging().appDidReceiveMessage(userInfo)

        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        print(userInfo)

        // To pass notification reciept information to Analytics,
        Messaging.messaging().appDidReceiveMessage(userInfo)

        completionHandler()
    }
}

/*
 APN 페이로드
 
 {
   "aps": {
     "alert": {
       "body": "great match!",
       "title": "Portugal vs. Denmark"
     },
     "badge": 1
   },
   "customKey": "customValue"
 }
 */
