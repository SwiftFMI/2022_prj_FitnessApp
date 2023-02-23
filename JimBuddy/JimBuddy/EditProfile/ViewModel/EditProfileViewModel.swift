//
//  EditProfileViewModel.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 23.02.23.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    @Published var user: User = User(firstName: "",
                                     lastName: "",
                                     gender: .male,
                                     goal: .maintainWeight,
                                     birthday: Date())
    @Published var hasError: Bool = false
    
    private var cancellables: Set<AnyCancellable> = .init()

    
    func loadUserData() {
        EditProfileService.shared.fetchDetailedUserData()
            .sink { [weak self] result in
                switch result {
                case .finished:
                    return
                case .failure(let error):
                    print(error)
                    self?.hasError = true
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }

    func updateUserData() {
        EditProfileService.shared.updateUserDetails(user: user) { [weak self] error in
            guard  error == nil else {
                self?.hasError = true
                return
            }
        }
    }
}
