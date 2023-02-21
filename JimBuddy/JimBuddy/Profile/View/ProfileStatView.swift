//
//  ProfileStatView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import SwiftUI

struct ProfileStatView: View {

    @Binding var stat: StatType
    @Binding var statValue: String

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: stat.statIconName)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .foregroundColor(Colors.green)

            Spacer()
            Text(stat.statName)
                .textCase(.uppercase)
                .foregroundColor(Colors.green)
                .font(.caption)
                .multilineTextAlignment(.center)
            Text(statValue)
                .foregroundColor(Colors.lightGrey)
                .font(.caption2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 110)
        .padding(10)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Colors.green, lineWidth: 2))
    }
}
