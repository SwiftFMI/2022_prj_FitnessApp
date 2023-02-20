//
//  PersonalDataViewModel.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import HealthKit
import FirebaseAuth
import Foundation
import UIKit

final class PersonalDataViewModel: ObservableObject {
    @Published var age: Int? = nil
    @Published var gender: Gender? = nil

    // default values so it doesnt look strange while loading
    @Published var firstName: String = "JimBuddy"
    @Published var lastName: String = "User"
    @Published var email: String? = nil

    @Published var userImage: UIImage = .init(named: "default_profile") ?? UIImage()

    @Published var healthSamples: [(stat: StatType, value: String)] = .init()
    @Published var displayError: Bool = false

    func loadFullData() {
        loadPersonalCharacteristics()
        loadQuantityProperties()
        loadUserData()
        loadImage()
    }

    func loadPersonalCharacteristics() {
        PersonalDataService.shared.getPersonalCharacteristicsHealthKit { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let characteristics):
                strongSelf.age = characteristics.age
                guard let gender = Gender(rawValue: characteristics.gender) else {
                    strongSelf.gender = .other
                    return
                }
                strongSelf.gender = gender
            case .failure:
                strongSelf.displayError = true
            }
        }
    }

    func loadUserData() {
        PersonalDataService.shared.getUserData { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let userData):
                strongSelf.firstName = userData.firstName
                strongSelf.lastName = userData.lastName
                strongSelf.email = userData.email
            case .failure:
                strongSelf.displayError = true
            }
        }
    }

    func loadImage() {
        guard let email = Auth.auth().currentUser?.email else {
            return
        }

        GravatarImageService.shared.loadImage(for: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.userImage = image
                case .failure:
                    self?.userImage = UIImage(named: "default_profile") ?? UIImage()
                }
            }
        }
    }

    func loadQuantityProperties() {
        PersonalDataService.shared.getQuantitySamples { [weak self] result in
            self?.healthSamples = result.sorted(by: { lhs, rhs in
                lhs.stat < rhs.stat
            })
            print("-->",result)
        }
    }
}
