//
//  CalorieProgressView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 13.02.23.
//

import SwiftUI

struct CalorieProgressView: View {
    var body: some View {
        ZStack(alignment: .center) {
            ProgressView(value: 40, total: 100)
                .progressViewStyle(.linear)
                .tint(Colors.green)
                .background(Colors.pink)
                .scaleEffect(x: 1, y: 25, anchor: .center)
                .frame(height: 40)

            HStack {
                VStack(alignment: .leading) {
                    Text("945 Cal")
                    Text("consumed").font(.caption2)
                }
                .padding(.leading, 10)

                Spacer()

                VStack(alignment: .trailing) {
                    Text("1623 Cal")
                    Text("to go").font(.caption2)
                }
                .padding(.trailing, 10)
            }
            .foregroundColor(.white)
        }
    }
}

struct CalorieProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieProgressView()
    }
}
