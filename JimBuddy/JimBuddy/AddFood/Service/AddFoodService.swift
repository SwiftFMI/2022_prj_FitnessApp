//
//  AddFoodService.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

enum AddFoodKeys: String {
    case name
    case calories
    case measuringUnits
    case quantity
    case consumptionTime
    case protein
    case carbs
    case fats
}

class AddFoodService {
    
    private let db = Firestore.firestore()
    private let notificationManager = NotificationManager()
    
    func addFoodForDay(date: String = Date.firebaseCurrentDate, addFoodModel: AddFoodModel) -> AnyPublisher<Void, FirebaseError> {
        Future<Void, FirebaseError> {
            [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(.generalError))
                return
            }
            guard let email = Auth.auth().currentUser?.email else {
                promise(.failure(.authError))
                return
            }
            
            let valuesToAdd = [AddFoodKeys.name.rawValue: addFoodModel.name,
                               AddFoodKeys.calories.rawValue: addFoodModel.calories,
                               AddFoodKeys.measuringUnits.rawValue : addFoodModel.measuringUnits.rawValue,
                               AddFoodKeys.quantity.rawValue: addFoodModel.quantity,
                               AddFoodKeys.consumptionTime.rawValue: addFoodModel.consumptionTime,
                               AddFoodKeys.protein.rawValue: addFoodModel.protein,
                               AddFoodKeys.carbs.rawValue: addFoodModel.carbs,
                               AddFoodKeys.fats.rawValue: addFoodModel.fats
            ] as [String: Any]
            strongSelf.db
                .collection("foodEntries/\(email)/\(date)")
                .addDocument(data: valuesToAdd) {
                    err in if err != nil {
                        promise(.failure(.errorInAddingDocument))
                    } else {

                        self?.scheduleNotification()
                        promise(.success(()))
                    }
                }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func scheduleNotification() {
        let notificationID = notificationManager.scheduleNotification(waitTime: 1)

        let defaults = UserDefaults.standard
        if let oldNotificationID = defaults.value(forKey: "lastNotificationID") as? String {
            notificationManager.removeScheduledNotification(notificationId: oldNotificationID)
        }

        defaults.set(notificationID, forKey: "lastNotificationID")
    }
}
