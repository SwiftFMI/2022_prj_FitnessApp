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
                .font(.system(size:20))
            Spacer()
            Text(String(value))
                .padding(10)
                .foregroundColor(.gray)
                .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 4))
                .font(.system(size:20))
        }.padding(10)
    }
}
