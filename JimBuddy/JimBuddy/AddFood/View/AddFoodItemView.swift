//
//  AddFoodItemView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import SwiftUI

struct AddFoodItemView: View {
    let propertyName: String
    let value: String
    
    var body: some View {
        HStack {
            Text(propertyName)
                .font(.callout)
                .textCase(.uppercase)
            Spacer()
            Text(String(value))
                .frame(minWidth: 120)
                .padding(.vertical, 5)
                .foregroundColor(Colors.green)
                .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Colors.green, lineWidth: 2))
        }
    }
}
