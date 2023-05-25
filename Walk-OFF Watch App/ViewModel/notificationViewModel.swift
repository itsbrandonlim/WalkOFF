//
//  TimerViewModel.swift
//  Walk-OFF Watch App
//
//  Created by Brandon Nicolas Marlim on 5/25/23.
//

//import Foundation
//import UserNotifications
//
//class Notification: ObservableObject {
//    @Published private var timer: Timer?
//    @Published private var remainingTime: TimeInterval = 0
//    @Published private var isWalking = false
//    let notificationCenter = UNUserNotificationCenter.current()
//    
//    func requestAuthorization(){
//        let options: UNAuthorizationOptions = [.alert,.badge,.sound]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
//            if let error = error {
//                print("ERROR \(error)")
//            }
//            else {
//                print("SUCCESS")
//            }
//        }
//    }
//    
//    func scheduleNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Great Job!"
//        content.body = "You've manage to stay active, now go back to work!"
//        content.sound = UNNotificationSound.default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 301, repeats: false)
//        
//        let request = UNNotificationRequest(
//            identifier: "GreatJobNotification",
//            content: content,
//            trigger: trigger
//        )
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling notification: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func startTimer() {
//        remainingTime = 300
//        scheduleNotification()
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
//            if self.remainingTime > 0{
//                self.remainingTime -= 1
//            } else {
//                self.stopTimer()
//            }
//        }
//        
//    }
//    
//    func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//        isWalking = false
//        
//        scheduleNotification()
//    }
//    
//    func timeString(from timeInterval: TimeInterval) -> String{
//        let minute = Int(timeInterval) / 60
//        let seconds = Int (timeInterval) % 60
//        return String(format: "%02d : %02d", minute, seconds)
//    }
//    
//}
