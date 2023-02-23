//
//  CalendarViewModel.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import Combine
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var friends: [FriendModel] = .init()
    @Published var hasError: Bool = false
    
    private var cancellables: Set<AnyCancellable> = .init()

    func loadFriends(date: String = Date.firebaseCurrentDate) {
        CalendarService.shared.fetchUsersPlanningToTrain(on: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.hasError = true
            case .success(let usersPlanningToTrain):
                CalendarService.shared.fetchFriends { result in
                    switch result {
                    case .success(let friends):
                        let filteredUsers = usersPlanningToTrain.filter({ friends.contains($0.email) })
                        self?.friends = filteredUsers
                        filteredUsers.forEach { self?.fetchImage(for: $0) }
                    case .failure(let error):
                        print(error)
                        self?.hasError = true
                    }
                }
            }
        }
    }

    func confirmWorkout(date: String) {
        CalendarService.shared.confirmWorkout(on: date)
            .sink { [weak self]  result in
                switch result {
                case .failure(let error):
                    print(error)
                    self?.hasError = true
                case .finished:
                    return
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
    }

    func addFriend(email: String) {
        CalendarService.shared.checkIfAccountExists(email: email) { [weak self] result in
            guard let strongSelf = self else{
                return
            }
            switch result {
            case true:
                CalendarService.shared.addFriend(email: email)
                    .sink { result in
                        switch result {
                        case .failure:
                            strongSelf.hasError = true
                        case .finished:
                            break
                        }
                    } receiveValue: { _ in /* empty closure */ }
                    .store(in: &strongSelf.cancellables)
            case false:
                print("User does not exist")
            }
        }
    }

    private func fetchImage(for user: FriendModel) {
        GravatarImageService.shared.loadImage(for: user.email) { [weak self] result in
            switch result {
            case .success(let image):
                let updatedUser = FriendModel(image: image, friendModel: user)
                guard let idx = self?.friends.firstIndex(where: { friend in
                    friend.email == user.email
                }) else {
                    return
                }
                DispatchQueue.main.async {
                    self?.friends[idx] = updatedUser
                }
            case .failure:
                return
            }
        }
    }
}
