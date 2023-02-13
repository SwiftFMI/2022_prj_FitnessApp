//
//  DiaryView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI

struct DiaryView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Calorie intake").textCase(nil)) {
                        CalorieProgressView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

                    }.padding(.vertical, 10)

                    Section(header: Text("Breakfast").textCase(nil)) {
                        FoodEntryView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)

                        FoodEntryView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }

                    Section(header: Text("Lunch").textCase(nil)) {
                        Text("No entries yet")
                    }

                    Section(header: Text("Dinner").textCase(nil)) {
                        Text("No entries yet")
                    }

                    Section(header: Text("Snacks").textCase(nil)) {
                        Text("No entries yet")
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Diary")
            .navigationBarTitleDisplayMode(.inline)
            .background(NavigationConfiguration())
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                        .tint(.white)
                }
            }
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
