//
//  Walk-OFF_View.swift
//  Walk-OFF Watch App
//
//  Created by Brandon Nicolas Marlim on 5/21/23.
//
import SwiftUI
import HealthKit
import UserNotifications
import librlottie
import SDWebImage
import SDWebImageLottieCoder

struct WalkOffPage: View {
    @State private var isWalking = false
    @State private var stepCount: Int = 0
    @State private var totalStepCount: Int = 0
    @State private var remainingTime: TimeInterval = 0
    @State private var timer: Timer?
    @ObservedObject var viewModel: LottieViewModel = .init()
    let healthStore = HKHealthStore()
    let notificationCenter = UNUserNotificationCenter.current()
    
    var body: some View {
        VStack {
            Button(action: {
                self.isWalking.toggle()
                if self.isWalking {
                    self.startTimer()
                    self.queryStepCount()
                }
                else{
                    self.stopTimer()
                }
            }) {
                if isWalking{
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .onAppear {self.viewModel.loadAnimationFromFile(filename: "walkOFF")}
                } else{
                    Image("WalkOFF")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
            }.buttonStyle(PlainButtonStyle())
            
            if isWalking{
                Text((timeString(from: remainingTime)))
                    .font(Font.system(size: 24).weight(.bold))
                    .foregroundColor(.primary)
            }else{
                Text("Tap to Start")
                    .font(Font.system(size: 24).weight(.bold))
                    .foregroundColor(.primary)
            }
            
            if !isWalking{
                Text("Steps: \(stepCount)")
                    .font(Font.system(.subheadline))
                    .foregroundColor(.blue)
            }
        }
        .onAppear{
            requestAuthorizationForHealth()
            requestAuthorization()
        }
    }
    // MARK: - HealthKit
    func requestAuthorizationForHealth() {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        healthStore.requestAuthorization(toShare: [stepCountType], read: [stepCountType]) { (success, error) in
            if success {
                scheduleNotification()
            } else {
                print("Error requesting HealthKit authorization: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func queryStepCount() {
            let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: Date())
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                if let error = error {
                    print("Error fetching step count: \(error.localizedDescription)")
                    return
                }
                
                if let result = result, let sum = result.sumQuantity() {
                    let stepCount = sum.doubleValue(for: HKUnit.count())
                    DispatchQueue.main.async {
                        self.stepCount = Int(stepCount)
                    }
                }
            }
            HKHealthStore().execute(query)
        }
    
    // MARK: - Notification and Timer
    //// Authorization for requesting notification
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR \(error)")
            }
            else {
                print("SUCCESS")
            }
        }
    }
    ////Notification schedule on a spesific time interval
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Great Job!"
        content.body = "You've manage to stay active, now go back to work!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)

        let request = UNNotificationRequest(
            identifier: "GreatJobNotification",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    ///// Timer Function
    func startTimer() {
        remainingTime = 60
        scheduleNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            if remainingTime > 0{
                remainingTime -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isWalking = false
        scheduleNotification()
    }

    func timeString(from timeInterval: TimeInterval) -> String{
        let minute = Int(timeInterval) / 60
        let seconds = Int (timeInterval) % 60
        return String(format: "%02d : %02d", minute, seconds)
    }
}

// MARK: - Preview
struct WalkOffPage_Previews: PreviewProvider {
    static var previews: some View {
        WalkOffPage()
    }
}


