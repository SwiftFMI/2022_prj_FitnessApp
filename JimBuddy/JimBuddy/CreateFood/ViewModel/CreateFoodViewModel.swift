//
//  CreateFoodViewModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 22.01.23.
//

import Foundation
import Combine

enum CreateFoodState {
    case successful
    case failed(error: Error)
    case loading
}

protocol CreateFoodViewModel {
    func createFood()
    var service: CreateFoodService { get }
    var state: CreateFoodState { get }
    var createFoodDetails : CreateFoodDetails { get }
    var hasError: Bool { get }
    init(service: CreateFoodService)
}

final class CreateFoodViewModelImpl: ObservableObject, CreateFoodViewModel {
    
    let service: CreateFoodService
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var state: CreateFoodState = .loading
    
    @Published var createFoodDetails: CreateFoodDetails = CreateFoodDetails.new
    
    @Published var hasError: Bool = false
    
    init(service: CreateFoodService) {
        self.service = service
        setupErrorSubscriptions()
    }
    
    func createFood() {
        self.state = .loading
        service.createFood(with: createFoodDetails)
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

private extension CreateFoodViewModelImpl{
    
    func setupErrorSubscriptions() {
        $state.map { state -> Bool in
            switch state {
            case .successful,
                    .loading :
                return false
            case .failed :
                return true
            }
        }
        .assign(to: &$hasError)
    }
}
