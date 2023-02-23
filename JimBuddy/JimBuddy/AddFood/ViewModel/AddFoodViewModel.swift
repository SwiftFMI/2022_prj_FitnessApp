//
//  AddFoodViewModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import Foundation
import Combine

class AddFoodViewModel: ObservableObject {
    
    let service: AddFoodService
    
    @Published var state: ScreenState = .loading
    
    @Published var hasError: Bool = false
    
    @Published var quantity: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: AddFoodService) {
        self.service = service
    }
    
    func addFood(addFoodUiModel: AddFoodUiModel) {
        self.state = .loading
        let foodQuantity = Int(quantity) ?? 0
        let addFoodDetails = addFoodUiModel.mapToDomainModel(quantity: foodQuantity)
        print(addFoodDetails)
        service.addFoodForDay(addFoodModel: addFoodDetails)
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
