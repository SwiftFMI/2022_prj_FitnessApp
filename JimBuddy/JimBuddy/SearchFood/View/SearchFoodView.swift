//
//  AddFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import SwiftUI

struct SearchFoodView: View {
    let navigationBarTitle: String
    @StateObject private var viewModel = SearchFoodViewModelImpl(service: SearchFoodService())
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(searchFoodResult, id: \.self) { currFood in
                    NavigationLink(destination: AddFoodView(foodItem: currFood.mapToAddFoodUiModel(givenConsumptionTime: navigationBarTitle))) {
                        SearchFoodEntryView(food: currFood)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
                    }
                }
            }
            
        }
        .navigationTitle(navigationBarTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CreateFoodView()) {
                    Text("Create food")
                }
            }
        })
        .searchable(text: $searchText)
        .onAppear {
            self.viewModel.loadFoods()
        }
    }
    
    var searchFoodResult: [SearchFoodDetails] {
        if searchText.isEmpty {
            return viewModel.foods
        } else {
            return viewModel.foods.filter { $0.name.contains(searchText) }
        }
    }
}
