//
//  AddFoodModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import Foundation

struct AddFoodModel {
    var name: String
    var calories: Int
    var measuringUnits: MeasuringUnits
    var quantity: Int
    var consumptionTime: String
    var protein: Double
    var carbs: Double
    var fats: Double
}

extension AddFoodModel {
    
    static var new: AddFoodModel {
        AddFoodModel(name: "", calories: 0, measuringUnits: MeasuringUnits.gram, quantity: 0, consumptionTime: "", protein: 0, carbs: 0, fats: 0)
    }
}
