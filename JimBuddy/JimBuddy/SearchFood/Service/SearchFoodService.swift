//
//  SearchFoodService.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 5.02.23.
//

import Foundation
import Combine
import FirebaseFirestore

class SearchFoodService {
    
    private let db = Firestore.firestore()

    var foods: [SearchFoodDetails] = []
    
    func loadFoods() -> AnyPublisher<[SearchFoodDetails], FirebaseError> {

        Deferred{
            Future { [weak self] promise in
                guard let strongSelf = self else {
                    promise(.failure(.generalError))
                    return
                }
                
                strongSelf.db.collection("foods").addSnapshotListener { documentSnapshot, error in
                    let result = strongSelf.validate(snapshot: documentSnapshot, error: error)
                    switch result {
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let snapshot):
                        let foodItems = snapshot.documents.compactMap { document in
                            strongSelf.parseFood(foodData: document.data(), documentId: document.documentID)
                        }
                        promise(.success(foodItems))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    private func parseFood(foodData: [String: Any], documentId: String) -> SearchFoodDetails? {

        guard let name = foodData["name"] as? String,
              let calories = foodData["calories"] as? Int,
              let measuringUnits = foodData["measuringUnits"] as? String,
              let units = MeasuringUnits(rawValue: measuringUnits),
              let quantity = foodData["quantity"] as? Int,
              let protein = foodData["protein"] as? Double,
              let carbs = foodData["carbs"] as? Double,
              let fats = foodData["fats"] as? Double
        else {
            return nil
        }
        return SearchFoodDetails(id: documentId,name: name, calories: calories, measuringUnits: units, quantity: quantity, protein: protein, carbs: carbs, fats: fats)
    }
    
    private func validate(snapshot: QuerySnapshot?, error: Error?) -> Result<QuerySnapshot, FirebaseError> {
        guard error == nil else {
            return .failure(.generalError)
        }

        guard let snapshot = snapshot else {
            return .failure(.emptySnapshot)
        }

        return .success(snapshot)
    }
}
