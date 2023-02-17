//
//  CreateFoodDetails.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 22.01.23.
//

import Foundation

struct CreateFoodDetails {
    var name: String
    var calories: String
    var measuringUnits: String
    var quantity: String
    var protein: String
    var carbs: String
    var fats: String
}

extension CreateFoodDetails {
    
    static var new: CreateFoodDetails {
        CreateFoodDetails(name: "", calories: "", measuringUnits: "", quantity: "", protein: "", carbs: "", fats:  "")
    }
}
