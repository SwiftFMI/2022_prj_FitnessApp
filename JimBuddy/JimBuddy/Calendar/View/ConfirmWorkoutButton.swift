//
//  ConfirmWorkoutButton.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 22.02.23.
//

import SwiftUI

struct ConfirmWorkoutButton: View {
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @Binding var buttonState: ButtonState
    var date: Date

    var body: some View {
        switch self.buttonState {
        case .active:
            HStack {
                Spacer()
                Button {
                    calendarViewModel.confirmWorkout(date: Date.formatFirebaseDate(date: date))
                } label: {
                    Text("Confirm workout")
                        .padding(.horizontal, 20)
                }
                .padding(.top, 10)
                .buttonStyle(.bordered)
                .tint(Colors.green)
                Spacer()
            }
        case .disabled:
            HStack {
                Spacer()
                Button {
                    print("disabled")
                } label: {
                    Text("Confirm workout")
                        .padding(.horizontal, 20)
                }
                .disabled(true)
                .padding(.top, 10)
                .buttonStyle(.bordered)
                .tint(Colors.lightGrey)
                Spacer()
            }
        }

    }

    enum ButtonState {
        case disabled
        case active
    }
}

