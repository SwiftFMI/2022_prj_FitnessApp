//
//  CreateFoodService.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 22.01.23.
//

import Combine
import Firebase
import FirebaseCore
import FirebaseFirestore
import Foundation

enum CreateFoodKeys: String {
    case name
    case quantity
    case measuringUnits
    case calories
    case protein
    case carbs
    case fats
}

protocol CreateFoodService {
    func createFood(with createFoodDetails: CreateFoodDetails) -> AnyPublisher<Void, Error>
}

final class CreateFoodServiceImpl: CreateFoodService {
    var db = Firestore.firestore()
    var ref : DocumentReference? = nil
    
    func createFood(with createFoodDetails:CreateFoodDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                let valuesToAdd = [CreateFoodKeys.name.rawValue: createFoodDetails.name,
                                   CreateFoodKeys.quantity.rawValue: Int(createFoodDetails.quantity) ?? 0,
                                   CreateFoodKeys.measuringUnits.rawValue: createFoodDetails.measuringUnits.rawValue,
                                   CreateFoodKeys.calories.rawValue: Int(createFoodDetails.calories) ?? 0,
                                   CreateFoodKeys.protein.rawValue: Double(createFoodDetails.protein) ?? 0,
                                   CreateFoodKeys.carbs.rawValue: Double(createFoodDetails.carbs) ?? 0,
                                   CreateFoodKeys.fats.rawValue: Double(createFoodDetails.fats) ?? 0] as [String: Any]
                self.ref = self.db.collection("foods").addDocument(data: valuesToAdd) {
                    err in if let err = err {
                        promise(.failure(err))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
