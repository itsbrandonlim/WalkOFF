//
//  RequestNotification.swift
//  Walk-OFF Watch App
//
//  Created by Brandon Nicolas Marlim on 5/23/23.
//

//import Foundation
//import UserNotifications
//import SwiftUI

//// Local notification
//schedule notification
//func schedulenotification(){
//    let content = UNMutableNotificationContent()
//    content.title = "Great Job!"
//    content.body = "you've manage to stay active, now go back to work!"
//    content.sound = UNNotificationSound.default
//
//    let trigger = UNTimeIntervalNotificationTrigger(
//        timeInterval: 1,
//        repeats: false
//    )
//
//    let request = UNNotificationRequest(
//        identifier: "GreatJobNotification",
//        content: content,
//        trigger: trigger
//    )
//
//    UNUserNotificationCenter.current().add(request) { error in
//        if let error = error {
//            print("Error scheduling notification: \(error.localizedDescription)")
//        }
//    }
//}

//func triggerNotification(){
//    let center = UNUserNotificationCenter.current()
//    center.getNotificationSettings(completionHandler: { settings in
//        if settings.authorizationStatus != .authorized {
//
//            center.requestAuthorization(options : [.alert, .sound, .badge]){
//                granted, error in
//
//                if let error = error {
//                    print("error : \(error)")
//                }
//            }
//        }
//    })
//}

//class NotificationHandler: NSObject, UNUserNotificationCenterDelegate{
//    static let shared = NotificationHandler()
    
    /** notification when app is in background */
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
    //
    //        let notiName = Notification.Name(response.notification.request.identifier)
    //        NotificationCenter.default.post(name: notiName, object: response.notification.request.content)
    //        completionHandler()
    //    }
    
    /** Handle notification when the app  is in foreground */
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
//        
//        let notiName = Notification.Name( notification.request.identifier)
//        NotificationCenter.default.post(name:notiName, object: notification.request.content)
//        completionHandler(.sound)
//    }
//}
