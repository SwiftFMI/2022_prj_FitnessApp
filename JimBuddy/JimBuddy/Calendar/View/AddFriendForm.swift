//
//  AddFriendForm.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//

import SwiftUI

struct AddFriendForm: View {
    @State var friendEmail: String = ""
    @EnvironmentObject var calendarViewModel: CalendarViewModel

    var body: some View {
        HStack(alignment: .center) {
            TextField("Friend email", text: $friendEmail)
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding(.leading, 10)
                .padding(.top, 0)
                .autocorrectionDisabled(true)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke()
                        .foregroundColor(Colors.lightGrey))
            Button {
                self.calendarViewModel.addFriend(email: friendEmail)
                self.friendEmail = ""
            } label: {
                Text("Add friend")
            }
            .buttonStyle(.bordered)
            .tint(Colors.green)
        }
    }
}
