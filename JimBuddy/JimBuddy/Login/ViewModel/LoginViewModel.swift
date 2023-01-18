//
//  LoginViewModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 17.01.23.
//

import Foundation
import Combine

enum LoginState{
    case successful
    case failed(error: Error)
    case notavailable
}

protocol LoginViewModel {
    func login()
    var service: LoginService { get }
    var state: LoginState { get }
    var credentials : LoginCredentials { get }
    var hasError: Bool { get }
    init(service: LoginService)
}

final class LoginViewModelImpl : ObservableObject, LoginViewModel {
    
    let service: LoginService
    
    @Published var hasError: Bool = false
    
    @Published var state: LoginState = .notavailable
    
    @Published var credentials: LoginCredentials = .new
    
    private var subscriptions =  Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func login() {
        service.login(with: credentials).sink { res in
            switch res {
            case .failure(let err):
                self.state = .failed(error: err)
            default: break
            }
        } receiveValue: { [weak self] in
            self?.state = .successful
        }
        .store(in: &subscriptions)
    }
}

private extension LoginViewModelImpl{
    
    func setupErrorSubscriptions() {
        $state.map { loginState -> Bool in
            switch loginState {
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
