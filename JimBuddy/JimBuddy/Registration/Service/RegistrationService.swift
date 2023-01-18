//
//  RegistrationService.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 14.01.23.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase

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
                Auth.auth().createUser(withEmail: userDetails.email, password: userDetails.password) {
                    res, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        if let uid = res?.user.uid {
                            let values = [RegistrationKeys.firstName.rawValue: userDetails.firstName,
                                          RegistrationKeys.lastName.rawValue: userDetails.secondName] as [String: Any]
                            
                            self.ref
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    if let error = error {
                                        promise(.failure(error))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
