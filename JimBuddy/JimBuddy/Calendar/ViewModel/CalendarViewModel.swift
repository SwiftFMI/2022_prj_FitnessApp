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

    private var cancellables: Set<AnyCancellable> = .init()

    func loadFriends(date: String = Date.firebaseCurrentDate) {
        CalendarService.shared.fetchFriendsPlanningToTrain(on: date) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let friends):
                self?.friends = friends
                friends.forEach { self?.fetchImage(for: $0) }
            }
        }
    }

    func confirmWorkout(date: String) {
        CalendarService.shared.confirmWorkout(on: date)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            } receiveValue: { _ in
            }
            .store(in: &cancellables)
    }

    func addFriend(email: String) {
        CalendarService.shared.checkIfAccountExists(email: email) { result in
            switch result {
            case true:
                CalendarService.shared.addFriend(email: email)
                    .sink { result in
                        switch result {
                        case .failure:
                            print("Add errpr")
                        case .finished:
                            break
                        }
                    } receiveValue: { _ in /* empty closure */ }
                    .store(in: &self.cancellables)
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
