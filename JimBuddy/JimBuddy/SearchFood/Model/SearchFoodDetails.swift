//
//  CreateFoodDetails.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 5.02.23.
//

import Foundation
import FirebaseFirestoreSwift

struct SearchFoodDetails: Identifiable {
    @DocumentID var id: String?
    var name: String
    var calories: Int
    var measuringUnits: MeasuringUnits
    var quantity: Int
    var protein: Double
    var carbs: Double
    var fats: Double
}

extension SearchFoodDetails {
    
    static var new: SearchFoodDetails {
        SearchFoodDetails(name: "", calories: 0, measuringUnits: .gram, quantity: 0, protein: 0, carbs: 0, fats: 0)
    }
}
