//
//  FriendCalendarView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import SwiftUI

struct FriendCalendarView: View {
    var body: some View {
        HStack {
            Image("default_profile")
                .resizable()
                .frame(width: 35, height: 35)
                .scaledToFit()
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Simeon Hristov")
                    .foregroundColor(Colors.darkGrey)
                Text("simeon.hr01@gmail.com")
                    .tint(Colors.lightGrey)
                    .foregroundColor(Colors.lightGrey)
                    .font(.caption)
            }
        }
    }
}
