//
//  PersonalDataService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import HealthKit
import UIKit

class PersonalDataService {
    static let shared: PersonalDataService = .init()

    private let healthKit: HKHealthStore
    private let dbReference = Firestore.firestore()

    private init() {
        self.healthKit = HKHealthStore()
    }

    func saveHealthDataInFirebase(age: Int, gender: String) {
        guard let email = Auth.auth().currentUser?.email else {
            return
        }

        dbReference
            .collection("Users")
            .document(email)
            .setData(["age": age,
                      "gender": gender],
                     mergeFields: ["age", "gender"])
    }

    func getPersonalCharacteristicsHealthKit(completion: @escaping (Result<(age: Int, gender: String), Error>) -> Void) {
        do {

            // try to get characteristics
            // if no authorization throws
            let birthdayComponents = try healthKit.dateOfBirthComponents()
            let biologicalSex = try healthKit.biologicalSex()

            // calculate age
            let today = Date()
            let calendar = Calendar.current

            let ageComponents = calendar.dateComponents([.year], from: birthdayComponents.date!, to: today)
            let age = ageComponents.year
            let gender = biologicalSex.biologicalSex
            let genderString: String

            // extract gender from biologicalSex
            switch gender {
            case .female:
                genderString = "Female"
            case .male:
                genderString = "Male"
            case .other:
                genderString = "Other"
            default:
                getPersonalCharacteristicsFirebase { result in
                    completion(result)
                }
                return
            }

            guard let age = age else {
                getPersonalCharacteristicsFirebase { result in
                    completion(result)
                }
                return
            }

            // return and save data
            completion(.success((age: age, gender: genderString)))
            saveHealthDataInFirebase(age: age, gender: genderString)
        } catch {

            // check if data is already in firebase
            getPersonalCharacteristicsFirebase { result in
                completion(result)
            }
        }
    }

    func getPersonalCharacteristicsFirebase(completion: @escaping (Result<(age: Int, gender: String), Error>) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(.failure(FirebaseError.authError))
            return
        }

        dbReference.collection("Users")
            .document(email.lowercased())
            .getDocument { [weak self] documentSnapshot, error in
                guard let strongSelf = self else {
                    completion(.failure(FirebaseError.generalError))
                    return
                }
                let result = strongSelf.validate(snapshot: documentSnapshot, error: error)

                switch result {
                case .success(let document):
                    let data = document.data()
                    guard let age = data?["age"] as? Int,
                          let gender = data?["gender"] as? String
                    else {
                        completion(.failure(FirebaseError.generalError))
                        return
                    }
                    completion(.success((age: age, gender: gender)))
                case .failure:
                    completion(.failure(FirebaseError.emptySnapshot))
                }
            }
    }

    func getUserData(completion: @escaping (Result<(firstName: String, lastName: String, email: String), Error>) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(.failure(FirebaseError.authError))
            return
        }

        dbReference.collection("Users")
            .document(email.lowercased())
            .getDocument { [weak self] documentSnapshot, error in
                guard let strongSelf = self else {
                    completion(.failure(FirebaseError.generalError))
                    return
                }
                let result = strongSelf.validate(snapshot: documentSnapshot, error: error)
                switch result {
                case .success(let document):
                    let data = document.data()
                    guard let fName = data?["firstName"] as? String,
                          let lName = data?["lastName"] as? String
                    else {
                        completion(.failure(FirebaseError.generalError))
                        return
                    }
                    completion(.success((firstName: fName, lastName: lName, email: email)))
                case .failure:
                    completion(.failure(FirebaseError.emptySnapshot))
                }
            }
    }

    func fetchImage(completion: @escaping (Result<UIImage, Error>) -> Void) {}

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
