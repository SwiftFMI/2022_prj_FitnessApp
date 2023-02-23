//
//  AddFoodUiModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import Foundation

struct AddFoodUiModel {
    var name: String
    var calories: Int
    var measuringUnit: MeasuringUnits
    var consumptionTime: String
    var protein: Double
    var carbs: Double
    var fats: Double
}

extension AddFoodUiModel {
    
    func mapToDomainModel(quantity: Int) -> AddFoodModel {
        AddFoodModel(name: self.name, calories: self.calories, measuringUnits: self.measuringUnit, quantity: quantity, consumptionTime: self.consumptionTime, protein: self.protein, carbs: self.carbs, fats: self.fats)
    }
}
