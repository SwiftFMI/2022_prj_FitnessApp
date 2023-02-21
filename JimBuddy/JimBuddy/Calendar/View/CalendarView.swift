//
//  CalendarView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SelectableCalendarView
import SwiftUI

struct CalendarView: View {
    @State private var dateSelected: Date = .init()
    @State private var showInfoSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    AddFriendForm()
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 20)

                    SelectableCalendarView(monthToDisplay: Date(), dateSelected: $dateSelected)
                        .listRowSeparator(.hidden)

                    HStack {
                        Spacer()
                        Button {
                            print("hi")
                        } label: {
                            Text("Confirm workout")
                                .padding(.horizontal, 20)
                        }
                        .padding(.top, 10)
                        .buttonStyle(.bordered)
                        .tint(Colors.green)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)

                    Divider()

                    FriendCalendarView()
                        .listRowSeparator(.hidden)

                    FriendCalendarView()
                        .listRowSeparator(.hidden)
                }
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
//        onAppear & onChange of date call for new data
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
