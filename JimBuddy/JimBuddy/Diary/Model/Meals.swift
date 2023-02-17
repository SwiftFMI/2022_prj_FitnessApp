//
//  Meals.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import Foundation

struct Meal: Identifiable, Hashable {
    var id = UUID()
    let name: String
}

extension Meal {
    
    static var initMeals: [Meal] = [
        .init(name: "Breakfast"),
        .init(name: "Lunch"),
        .init(name: "Dinner")
    ]
}
