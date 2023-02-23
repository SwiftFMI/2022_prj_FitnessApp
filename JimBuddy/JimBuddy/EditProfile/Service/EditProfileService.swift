//
//  EditProfileService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 23.02.23.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditProfileService {
    static let shared: EditProfileService = .init()

    private let dbReference = Firestore.firestore()

    private init() {}

    func fetchDetailedUserData() -> AnyPublisher<User, FirebaseError> {
        Deferred {
            Future { [weak self] promise in
                guard let strongSelf = self else {
                    return
                }

                guard let email = Auth.auth().currentUser?.email else {
                    promise(.failure(.authError))
                    return
                }

                strongSelf.dbReference.collection("Users").document(email).getDocument(completion: { documentSnapshot, error in
                    let result = strongSelf.validate(snapshot: documentSnapshot, error: error)

                    switch result {
                    case .success(let document):
                        guard let data = document.data() else {
                            promise(.failure(.generalError))
                            return
                        }
                        
                        let user = strongSelf.procesUserDocumentData(data: data)
                        guard let user else {
                            promise(.failure(.generalError))
                            return
                        }
                        promise(.success(user))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                })
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func updateUserDetails(user: User, completion: @escaping (FirebaseError?) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(.authError)
            return
        }

        dbReference.collection("Users")
            .document(email)
            .setData(["firstName": user.firstName,
                      "lastName": user.lastName,
                      "birthday": user.birthday,
                      "gender": user.gender.rawValue,
                      "goal": user.goal.rawValue]) { error in
                guard error == nil else {
                    completion(.generalError)
                    return
                }
                completion(nil)
            }
    }

    private func procesUserDocumentData(data: [String: Any]) -> User? {
        guard let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String else {
            return nil
        }


        var gender = Gender.male
        if let genderStr = data["gender"] as? String,
           let parsed = Gender(rawValue: genderStr) {
            gender = parsed
        }

        var goal = Goal.maintainWeight
        if let goalStr = data["goal"] as? String,
           let parsed = Goal(rawValue: goalStr) {
            goal = parsed
        }

        var birthday = Date()
        if let birthdayTimestamp = data["birthday"] as? Timestamp {
            birthday = Date.getDateFrom(timestamp: birthdayTimestamp)
        }


        return User(firstName: firstName,
                    lastName: lastName, gender: gender, goal: goal, birthday: birthday)
    }

    private func validate(snapshot: DocumentSnapshot?, error: Error?) -> Result<DocumentSnapshot, FirebaseError> {
        guard error == nil else {
            return .failure(.generalError)
        }

        guard let snapshot = snapshot else {
            return .failure(.emptySnapshot)
        }

        return .success(snapshot)
    }
}
