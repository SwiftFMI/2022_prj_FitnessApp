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

    func saveHealthDataInFirebase(birthday: Date, gender: String) {
        guard let email = Auth.auth().currentUser?.email else {
            return
        }

        dbReference
            .collection("Users")
            .document(email)
            .setData(["birthday": birthday,
                      "gender": gender],
                     mergeFields: ["birthday", "gender"])
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
            let age = ageComponents.year!
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
                genderString = "Other"
            }

            // return and save data
            completion(.success((age: age, gender: genderString)))
            saveHealthDataInFirebase(birthday: birthdayComponents.date!, gender: genderString)
        } catch {
            completion(.failure(FirebaseError.generalError))
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
                    guard let birthday = data?["birthday"] as? Timestamp,
                          let gender = data?["gender"] as? String
                    else {
                        self?.getPersonalCharacteristicsHealthKit(completion: { result in
                            completion(result)
                        })
                        return
                    }
                    let age = strongSelf.procesBirthdayTimestamp(birthday)
                    completion(.success((age: age, gender: gender)))
                case .failure:
                    // try to get them from Health
                    self?.getPersonalCharacteristicsHealthKit(completion: { result in
                        completion(result)
                    })
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

    func getQuantitySamples(completion: @escaping ([(stat: StatType, value: String)]) -> Void) {
        // something like a semaphore
        // needed to assure all data has been fetched before returning it
        let dispatchGroup = DispatchGroup()
        var sampleData: [(stat: StatType, value: String)] = .init()

        for (stat, sample) in StatType.allTypes {
            dispatchGroup.enter()
            guard let sample = sample else {
                dispatchGroup.leave()
                continue
            }

            getSample(for: sample) { [weak self ] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let quantitySample):
                    let value = strongSelf.procesSample(sample: quantitySample, type: stat)
                    sampleData.append((stat: stat, value: value))
                case .failure:
                    break // ignore failed sampleQueries
                }
                dispatchGroup.leave()
            }
        }

        // return samples for which we have received data
        dispatchGroup.notify(queue: .main) {
            completion(sampleData)
        }
    }

    func getSample(for sampleType: HKSampleType,
                   completion: @escaping (Result<HKQuantitySample, Error>) -> Void)
    {
        // 1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)

        let limit = 1

        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { _, samples, _ in
            guard let samples = samples,
                  let mostRecentSample = samples.first as? HKQuantitySample
            else {
                completion(.failure(APIError.otherProblem))
                return
            }

            completion(.success(mostRecentSample))
        }

        healthKit.execute(sampleQuery)
    }

    private func procesSample(sample: HKQuantitySample, type: StatType) -> String {
        let result: Double
        switch type {
        case .steps:
            result = sample.quantity.doubleValue(for: .count())
            return String(format: "%.0f", result)
        case .caloriesBurned:
            result = sample.quantity.doubleValue(for: .kilocalorie())
            return String(format: "%.0f kCal", result)
        case .bodyWeight:
            result = sample.quantity.doubleValue(for: .gram())
            return String(format: "%.1f kg", result / 1000)
        case .height:
            result = sample.quantity.doubleValue(for: .meter())
            return String(format: "%.2f m", result)
        case .exerciseTime:
            result = sample.quantity.doubleValue(for: .hour())
            return String(format: "%.2f h", result)
        case .moveDistance:
            result = sample.quantity.doubleValue(for: .meter())
            return String(format: "%.1f km", result / 1000)
        }
    }

    private func procesBirthdayTimestamp(_ timestamp: Timestamp) -> Int {
        let date = Date.getDateFrom(timestamp: timestamp)

        let today = Date()
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: date, to: today)
        return ageComponents.year!
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
