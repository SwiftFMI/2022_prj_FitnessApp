//
//  SwiftUIView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 12.02.23.
//

import SwiftUI

struct FoodEntryView: View {
    @Binding var foodItem: FoodItem

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(foodItem.name)
                    .foregroundColor(Colors.darkGrey)
                HStack(alignment: .center) {
                    Text("\(foodItem.quantity), \(foodItem.measuringUnits.rawValue)")
                        .font(.caption2)
                        .foregroundColor(Colors.lightGrey)
                }
            }
            Spacer()
            Text("\(foodItem.calories) kCal")
                .font(.caption)
                .foregroundColor(Colors.darkGrey)
        }
    }
}
