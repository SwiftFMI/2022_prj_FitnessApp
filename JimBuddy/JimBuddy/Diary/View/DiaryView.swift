//
//  DiaryView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI

struct DiaryView: View {
    @StateObject private var model: FoodItemViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Calorie intake").textCase(nil)) {
                        CalorieProgressView(consumed: $model.consumedCalories)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

                    }.padding(.vertical, 10)

                    Section(header: Text("Breakfast").textCase(nil)) {
                        ForEach(model.breakfastItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$model.breakfastItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        AddFoodView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }

                    Section(header: Text("Lunch").textCase(nil)) {
                        ForEach(model.lunchItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$model.lunchItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        AddFoodView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }

                    Section(header: Text("Dinner").textCase(nil)) {
                        ForEach(model.dinnerItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$model.dinnerItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        AddFoodView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }

                    Section(header: Text("Snacks").textCase(nil)) {
                        ForEach(model.snackItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$model.snackItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        AddFoodView()
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    self.model.loadFoodItems()
                }
            }
            .navigationTitle("Diary")
            .navigationBarTitleDisplayMode(.inline)
            .background(NavigationConfiguration())
            .toolbar {
                NavigationLink {
                    CalendarView()
                } label: {
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
