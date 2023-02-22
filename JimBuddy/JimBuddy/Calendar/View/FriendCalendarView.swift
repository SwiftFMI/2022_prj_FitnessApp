//
//  FriendCalendarView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import SwiftUI

struct FriendCalendarView: View {

    @Binding var user: FriendModel
    
    var body: some View {
        HStack {
            Image(uiImage: user.image)
                .resizable()
                .frame(width: 35, height: 35)
                .scaledToFit()
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(user.name)
                    .foregroundColor(Colors.darkGrey)
                Text(user.email)
                    .tint(Colors.lightGrey)
                    .foregroundColor(Colors.lightGrey)
                    .font(.caption)
            }
        }
    }
}
