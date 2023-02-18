//
//  FirebaseService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 16.02.23.
//
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class DiaryService: ObservableObject {

    static let shared: DiaryService = .init()

    private init() {}

    private let dbReference = Firestore.firestore()

    func fetchFoodEntries(date: String = Date.firebaseCurrentDate) -> AnyPublisher<[FoodItem], FirebaseError> {
        Future<[FoodItem], FirebaseError> { [weak self] promise in
            guard let strongSelf = self else {
                promise(.failure(.generalError))
                return
            }
            guard let email = Auth.auth().currentUser?.email else {
                promise(.failure(.authError))
                return
            }

            strongSelf.dbReference
                .collection("foodEntries/\(email)/\(date)")
                .getDocuments { querySnapshot, error in
                    let result = strongSelf.validate(snapshot: querySnapshot, error: error)

                    switch result {
                    case .failure(let error):
                        promise(.failure(error))
                    case .success(let snapshot):
                        let foodItems = snapshot.documents.compactMap { document in
                            strongSelf.parseFoodItem(foodData: document.data(), documentID: document.documentID)
                        }
                        promise(.success(foodItems))
                    }
                }
        }.eraseToAnyPublisher()
    }

    // documentId would be later needed for updating firebase data
    private func parseFoodItem(foodData: [String: Any], documentID: String) -> FoodItem? {
        guard let name = foodData["name"] as? String,
              let calories = foodData["calories"] as? Int,
              let measuringUnits = foodData["measuringUnits"] as? String,
              let units = MeasuringUnits(rawValue: measuringUnits),
              let quantity = foodData["quantity"] as? Int,
              let consumptionTime = foodData["consumptionTime"] as? String,
              let time = ConsumptionTime(rawValue: consumptionTime)
        else {
            return nil
        }

        return FoodItem(id: documentID,
                        name: name,
                        calories: calories,
                        measuringUnits: units,
                        quantity: quantity,
                        consumptionTime: time)
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
