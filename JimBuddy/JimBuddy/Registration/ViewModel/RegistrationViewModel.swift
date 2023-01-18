//
//  RegistrationViewModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 15.01.23.
//

import Foundation
import Combine

enum RegistrationState {
    case successful
    case failed(error: Error)
    case notavailable
}

protocol RegistrationViewModel {
    func register()
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var userDetails: RegistrationDetails { get }
    var hasError: Bool { get }
    init(service: RegistrationService)
}

final class RegistrationViewModelImpl: ObservableObject, RegistrationViewModel {
    
    let service: RegistrationService
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var hasError: Bool = false
    
    @Published var state: RegistrationState = .notavailable
    
    @Published var userDetails: RegistrationDetails = RegistrationDetails.new
    
    init(service: RegistrationService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func register() {
        service.register(with: userDetails)
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }.store(in: &subscriptions)
    }
}

private extension RegistrationViewModelImpl{
    
    func setupErrorSubscriptions() {
        $state.map { state -> Bool in
            switch state {
            case .successful,
                    .notavailable :
                return false
            case .failed :
                return true
            }
        }
        .assign(to: &$hasError)
    }
}

