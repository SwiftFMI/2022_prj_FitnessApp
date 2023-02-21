//
//  RegistrationService.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 14.01.23.
//

import Combine
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import Foundation

enum RegistrationKeys: String {
    case firstName
    case lastName
}

protocol RegistrationService {
    func register(with userDetails: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImpl: RegistrationService {
    var ref = Database.database().reference()

    func register(with userDetails: RegistrationDetails) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth().createUser(withEmail: userDetails.email, password: userDetails.password) { [weak self] res, error in
                    if let err = error {
                        promise(.failure(err))
                        return
                    }
                    if let uid = res?.user.uid {
                        let values = [RegistrationKeys.firstName.rawValue: userDetails.firstName,
                                      RegistrationKeys.lastName.rawValue: userDetails.secondName] as [String: Any]
                        self?.ref
                            .child("users")
                            .child(uid)
                            .updateChildValues(values) { error, _ in
                                if let error = error {
                                    promise(.failure(error))
                                    return
                                }

                                self?.addUserToFirestore(email: userDetails.email.lowercased(),
                                                         firstName: userDetails.firstName,
                                                         lastName: userDetails.secondName) { error in
                                    if let error = error {
                                        promise(.failure(error))
                                        return
                                    }

                                    promise(.success(()))
                                }
                            }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func addUserToFirestore(email: String,
                            firstName: String,
                            lastName: String,
                            completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("Users").document("\(email)").setData(["firstName": firstName,
                                                             "lastName": lastName]) { error in
            completion(error)
        }
    }
}
