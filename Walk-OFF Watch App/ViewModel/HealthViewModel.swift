//
//  HealthViewModel.swift
//  Walk-OFF Watch App
//
//  Created by Brandon Nicolas Marlim on 5/25/23.
//

//import Foundation
//import HealthKit
//
//class health: ObservableObject{
//    @Published private var stepCount: Int = 0
//    let healthStore = HKHealthStore()
//    @ObservedObject var viewModel: notificationViewModel = .init()
//
//    
//    func requestAuthorizationForHealth() {
//        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        healthStore.requestAuthorization(toShare: [stepCountType], read: [stepCountType]) { (success, error) in
//            if success {
//                scheduleNotification()
//            } else {
//                print("Error requesting HealthKit authorization: \(error?.localizedDescription ?? "")")
//            }
//        }
//    }
//    
//    func queryStepCount() {
//            let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//            let calendar = Calendar.current
//            let startDate = calendar.startOfDay(for: Date())
//            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
//            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//            
//            let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
//                if let error = error {
//                    print("Error fetching step count: \(error.localizedDescription)")
//                    return
//                }
//                
//                if let result = result, let sum = result.sumQuantity() {
//                    let stepCount = sum.doubleValue(for: HKUnit.count())
//                    DispatchQueue.main.async {
//                        self.stepCount = Int(stepCount)
//                    }
//                }
//            }
//            
//            HKHealthStore().execute(query)
//        
//    }
//
//
//    
//}
