//
//  CalorieProgressView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 13.02.23.
//

import SwiftUI

struct CalorieProgressView: View {
    @Binding var consumed: Double

    var body: some View {
        ZStack(alignment: .center) {
            ProgressView(value: consumed, total: 2300)
                .progressViewStyle(.linear)
                .tint(Colors.green)
                .background(Colors.pink)
                .scaleEffect(x: 1, y: 25, anchor: .center)
                .frame(height: 40)
 
            HStack {
                VStack(alignment: .leading) {
                    Text("\(Int(consumed)) kCal")
                    Text("consumed").font(.caption2)
                }
                .padding(.leading, 10)

                Spacer()

                VStack(alignment: .trailing) {
                    Text("1623 kCal")
                    Text("to go").font(.caption2)
                }
                .padding(.trailing, 10)
            }
            .foregroundColor(.white)
        }
    }
}
