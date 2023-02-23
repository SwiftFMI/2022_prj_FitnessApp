//
//  File.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 18.02.23.
//

import Combine
import SwiftUI

final class FoodItemViewModel: ObservableObject {
    var foodItems: [FoodItem] = .init()

    @Published var consumedCalories: Double = 0
    @Published var snackItems: [FoodItem] = .init()
    @Published var breakfastItems: [FoodItem] = .init()
    @Published var lunchItems: [FoodItem] = .init()
    @Published var dinnerItems: [FoodItem] = .init()
    @Published var hasError: Bool = false
    
    private var cancellables: Set<AnyCancellable> = .init()

    func loadFoodItems() {
        DiaryService.shared.fetchFoodEntries()
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                    self?.hasError = true
                case .finished:
                    return
                }
            } receiveValue: { [weak self] foodItems in
                self?.foodItems = foodItems
                self?.calculateConsumedCalories()
                self?.sortFoodItems()
            }
            .store(in: &cancellables)
    }

    private func calculateConsumedCalories() {
        var currentAmount = 0
       
        for foodItem in foodItems {
            if foodItem.measuringUnits == .piece {
                currentAmount += foodItem.calories * foodItem.quantity
            } else {
                currentAmount += foodItem.calories * (foodItem.quantity/100)
            }
        }

        consumedCalories = Double(currentAmount)
    }

    private func sortFoodItems() {
        snackItems.removeAll()
        breakfastItems.removeAll()
        lunchItems.removeAll()
        dinnerItems.removeAll()

        foodItems.forEach { foodItem in
            switch foodItem.consumptionTime {
            case .breakfast:
                breakfastItems.append(foodItem)
            case .lunch:
                lunchItems.append(foodItem)
            case .dinner:
                dinnerItems.append(foodItem)
            case .snacks:
                snackItems.append(foodItem)
            }
        }
    }
}
