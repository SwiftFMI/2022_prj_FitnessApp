//
//  CalendarService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import Combine
import Firebase
import FirebaseFirestore
import Foundation
import UIKit

class CalendarService {
    static let shared: CalendarService = .init()

    private init() {}

    private let dbReference = Firestore.firestore()

    func fetchFriendsPlanningToTrain(on date: String = Date.firebaseCurrentDate, completion: @escaping (Result<[FriendModel], FirebaseError>) -> Void) {
        dbReference
            .collection("WorkoutPlans/\(date)/Users")
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let strongSelf = self else {
                    completion(.failure(.generalError))
                    return
                }

                let result = strongSelf.validate(snapshot: querySnapshot, error: error)

                switch result {
                case .success(let snapshot):
                    let friends = snapshot.documents.compactMap { document in
                        strongSelf.procesFriendModel(data: document.data(), documentID: document.documentID)
                    }
                    completion(.success(friends))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func confirmWorkout(on date: String) -> AnyPublisher<Void, FirebaseError> {
        Deferred {
            Future { [weak self] promise in
                PersonalDataService.shared.getUserData { result in
                    switch result {
                    case .success(let names):
                        self?.postWorkoutConfirmation(on: date,
                                                      firstName: names.firstName,
                                                      lastName: names.lastName,
                                                      completion: { error in
                                                          guard error == nil else {
                                                              promise(.failure(.generalError))
                                                              return
                                                          }
                                                          promise(.success(()))
                                                      })
                    case .failure:
                        promise(.failure(.authError))
                    }
                }
            }
        }.receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private func postWorkoutConfirmation(on date: String,
                                         firstName: String,
                                         lastName: String,
                                         completion: @escaping (Error?) -> Void)
    {
        guard let email = Auth.auth().currentUser?.email else {
            completion(FirebaseError.authError)
            return
        }

        dbReference.collection("WorkoutPlans/\(date)/Users")
            .document(email)
            .setData(["firstName": firstName,
                      "lastName": lastName]) { error in
                guard error == nil else {
                    completion(FirebaseError.generalError)
                    return
                }

                completion(nil)
            }
    }

    func checkIfAccountExists(email: String, completion: @escaping (Bool) -> Void) {
        dbReference.collection("Users")
            .document(email.lowercased())
            .getDocument { document, _ in
                guard let document = document,
                          document.exists else {
                    completion(false)
                    return
                }

                completion(true)
            }
    }

    func addFriend(email: String) -> AnyPublisher<Void, FirebaseError> {
        Deferred {
            Future { promise in
                guard let currentUser = Auth.auth().currentUser?.email else {
                    promise(.failure(.authError))
                    return
                }

                var didReceiveError = false
                let dispatchGroup = DispatchGroup()

                dispatchGroup.enter()
                self.dbReference.collection("Users/\(email.lowercased())/Friends").document(currentUser).setData([:]) { error in
                    guard error == nil else {
                        didReceiveError = true
                        return
                    }

                    dispatchGroup.leave()
                }

                dispatchGroup.enter()
                self.dbReference.collection("Users/\(currentUser)/Friends").document(email.lowercased()).setData([:]) { error in
                    guard error == nil else {
                        didReceiveError = true
                        return
                    }

                    dispatchGroup.leave()
                }

                dispatchGroup.notify(queue: .main) {
                    guard !didReceiveError else {
                        promise(.failure(.generalError))
                        return
                    }
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }

    private func procesFriendModel(data: [String: Any], documentID: String) -> FriendModel? {
        guard let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String
        else {
            return nil
        }

        return FriendModel(image: UIImage(named: "default_profile") ?? UIImage(),
                           email: documentID,
                           name: "\(firstName) \(lastName)")
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
