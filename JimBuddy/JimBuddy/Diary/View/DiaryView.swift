//
//  DiaryView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI
import UserNotifications

struct DiaryView: View {
    @StateObject private var diaryViewModel: FoodItemViewModel = .init()
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    Section(header: Text("Calorie intake").textCase(nil)) {
                        CalorieProgressView(consumed: $diaryViewModel.consumedCalories)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.padding(.vertical, 10)
                    
                    Section(header: Text("Breakfast").textCase(nil)) {
                        ForEach(diaryViewModel.breakfastItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$diaryViewModel.breakfastItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        NavigationLink(destination: SearchFoodView(navigationBarTitle: "Breakfast")) {
                            DairyAddFoodView()
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    Section(header: Text("Lunch").textCase(nil)) {
                        ForEach(diaryViewModel.lunchItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$diaryViewModel.lunchItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        NavigationLink(destination: SearchFoodView(navigationBarTitle: "Lunch")) {
                            DairyAddFoodView()
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    Section(header: Text("Dinner").textCase(nil)) {
                        ForEach(diaryViewModel.dinnerItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$diaryViewModel.dinnerItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        NavigationLink(destination: SearchFoodView(navigationBarTitle: "Dinner")) {
                            DairyAddFoodView()
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                    }
                    
                    Section(header: Text("Snacks").textCase(nil)) {
                        ForEach(diaryViewModel.snackItems.indices, id: \.self) { idx in
                            FoodEntryView(foodItem: self.$diaryViewModel.snackItems[idx])
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                        NavigationLink(destination: SearchFoodView(navigationBarTitle: "Snacks")) {
                            DairyAddFoodView()
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    self.diaryViewModel.loadFoodItems()
                }
            }
            .navigationTitle("Diary")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $diaryViewModel.hasError) {
                Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
