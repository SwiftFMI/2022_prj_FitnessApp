//
//  FoodItem.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 16.02.23.
//

import Foundation

struct FoodItem: Identifiable {
    var id: String
    let name: String
    let calories: Int
    let measuringUnits: MeasuringUnits
    let quantity: Int
    let consumptionTime: ConsumptionTime
}

