//
//  SearchFoodEntryView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 19.02.23.
//

import SwiftUI

struct SearchFoodEntryView: View {
    var food: SearchFoodDetails
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(food.name)
                    .foregroundColor(Colors.darkGrey)
                HStack(alignment: .center) {
                    Text("\(food.quantity), \(food.measuringUnits.rawValue)")
                        .font(.caption2)
                        .foregroundColor(Colors.lightGrey)
                }
            }
            Spacer()
            Text("\(food.calories) kCal")
                .font(.caption)
                .foregroundColor(Colors.darkGrey)
        }
    }
}
