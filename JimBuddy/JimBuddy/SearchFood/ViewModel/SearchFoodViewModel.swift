//
//  SearchFoodViewModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 5.02.23.
//

import Foundation
import Combine

protocol SearchFoodViewModel {
    func loadFoods()
    var service: SearchFoodService { get }
    var state: ScreenState { get }
    var hasError: Bool { get }
    init(service: SearchFoodService)
}

final class SearchFoodViewModelImpl: ObservableObject, SearchFoodViewModel {
    
    var service: SearchFoodService
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var state: ScreenState = .loading
    
    @Published var foods : [SearchFoodDetails] = .init()
    
    @Published var hasError: Bool = false
    
    init(service: SearchFoodService) {
        self.service = service
    }
    
    func loadFoods() {
        self.state = .loading
        service.loadFoods()
            .sink { [weak self] res in
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: return
                }
            } receiveValue: { [weak self] foodsItems in
                self?.state = .successful
                self?.foods = foodsItems
            }.store(in: &subscriptions)
    }
}
