//
//  CalendarView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SelectableCalendarView
import SwiftUI

struct CalendarView: View {

    @StateObject private var calendarViewModel: CalendarViewModel = .init()
    @State private var dateSelected: Date = .init()
    @State private var showInfoSheet = false
    @State private var buttonState: ConfirmWorkoutButton.ButtonState = .active

    var body: some View {
        NavigationView {
            VStack {
                List {
                    AddFriendForm()
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 20)
                        .animation(nil, value: calendarViewModel.friends.count)

                    SelectableCalendarView(monthToDisplay: Date(), dateSelected: $dateSelected)
                        .listRowSeparator(.hidden)
                        .animation(nil, value: calendarViewModel.friends.count)
                    
                    ConfirmWorkoutButton(buttonState: $buttonState, date: dateSelected)
                        .environmentObject(calendarViewModel)
                    .listRowSeparator(.hidden)
                    .animation(nil, value: calendarViewModel.friends.count)

                    Divider()
                        .listRowSeparator(.hidden)
                        .animation(nil, value: calendarViewModel.friends.count)

                    ForEach($calendarViewModel.friends.indices, id: \.self) { idx in
                        FriendCalendarView(user: self.$calendarViewModel.friends[idx])
                            .listRowSeparator(.hidden)
                    }
                }
                .animation(.easeIn(duration: 0.01), value: calendarViewModel.friends.count)
                .listStyle(.plain)
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "info.circle")
                        .tint(Colors.darkGrey)
                        .onTapGesture {
                            showInfoSheet.toggle()
                        }
                }
            }
            .sheet(isPresented: $showInfoSheet) {
                CalendarInfoSheet()
            }
        }
        .onAppear {
            self.calendarViewModel.loadFriends(date: Date.formatFirebaseDate(date: self.dateSelected))
        }
        .onChange(of: dateSelected) { newValue in
            self.buttonState = .active
            if Calendar.current.compare(Date(), to: newValue, toGranularity: .day) == .orderedDescending {
                self.buttonState = .disabled
            }
            self.calendarViewModel.loadFriends(date: Date.formatFirebaseDate(date: self.dateSelected))
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
