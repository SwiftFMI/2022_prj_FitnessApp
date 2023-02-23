//
//  MacrosItemView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import SwiftUI

struct MacrosItemView: View {
    let macros: Macros
    let macrosValue: String
    
    var body: some View {
        VStack{
            Text(macros.name)
                .font(.subheadline)
                .foregroundColor(macros.color)
            Text(macrosValue)
                .font(.subheadline)
                .foregroundColor(Colors.lightGrey)
        }
        .frame(minWidth: 60)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(macros.color, lineWidth: 2))
    }

    enum Macros {
        case protein
        case carb
        case fat

        var name: String {
            switch self {
            case .protein:
                return "Protein"
            case .carb:
                return "Carbs"
            case .fat:
                return "Fats"
            }
        }
        var color: Color {
            switch self {
            case .protein:
                return Colors.green
            case .carb:
                return Colors.purple
            case .fat:
                return Colors.yellow
            }
        }
    }
}
