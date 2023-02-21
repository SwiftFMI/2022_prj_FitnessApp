//
//  EditProfile.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 2.03.23.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl

    @State private var date = Date()
    @State var text = ""
    @State var gender = Gender.male
    @State var goal = Goal.maintainWeight
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 2) {
                Text("First name")
                    .font(.caption)
                    .padding(.bottom, 0)
                    .foregroundColor(Colors.darkGrey)
                TextField("", text: $text)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .padding(.leading, 10)
                    .padding(.top, 0)
                    .autocorrectionDisabled(true)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke()
                            .foregroundColor(Colors.lightGrey))
            }
            .listRowSeparator(.hidden)
            .padding(0)
            .padding(.top, 40)

            VStack(alignment: .leading, spacing: 2) {
                Text("Last name")
                    .font(.caption)
                    .padding(.bottom, 0)
                    .foregroundColor(Colors.darkGrey)
                TextField("", text: $text)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .padding(.leading, 10)
                    .padding(.top, 0)
                    .autocorrectionDisabled(true)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke()
                            .foregroundColor(Colors.lightGrey))
            }
            .listRowSeparator(.hidden)
            .padding(0)

            Picker("Gender", selection: $gender) {
                Text("Male").tag(Gender.male)
                Text("Female").tag(Gender.female)
                Text("Other").tag(Gender.other)
            }
            .foregroundColor(Colors.darkGrey)
            .listRowSeparator(.hidden)

            Picker("Goal", selection: $goal) {
                Text("Lose weight").tag(Goal.loseWeight)
                Text("Maintain weight").tag(Goal.maintainWeight)
                Text("Gain weight").tag(Goal.gainWeight)
            }
            .foregroundColor(Colors.darkGrey)
            .listRowSeparator(.hidden)

            DatePicker(
                "Birthday",
                selection: $date,
                displayedComponents: [.date])
                .padding(.horizontal, 0)
                .datePickerStyle(.automatic)
                .foregroundColor(Colors.darkGrey)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Edit Profile")
        .toolbar {
            Button {
                sessionService.logout()
            } label: {
                Image(systemName: "door.left.hand.open")
                    .tint(Colors.darkGrey)
            }
        }

        Button {
            print("Save")
        } label: {
            HStack {
                Image(systemName: "checkmark")
                Text("Save")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
        .buttonStyle(.bordered)
        .tint(Colors.green)
        .padding(.bottom, 20)
    }
}
