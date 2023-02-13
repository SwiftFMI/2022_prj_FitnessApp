//
//  SwiftUIView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 12.02.23.
//

import SwiftUI

struct FoodEntryView: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("Boiled egg")
                    .foregroundColor(Colors.darkGrey)
                HStack(alignment: .center) {
                    Text("2, piece")
                        .font(.caption2)
                        .foregroundColor(Colors.lightGrey)
                }
            }
            Spacer()
            Text("140 Cal")
                .font(.caption)
                .foregroundColor(Colors.darkGrey)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FoodEntryView()
    }
}
