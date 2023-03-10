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
    @State private var showCreateFoodScreen = false
    @State private var showAddFoodScreen = false
    @State private var selectedItem = SearchFoodDetails.new
    
    var body: some View {
        let localSelectedItem = self.selectedItem
        
        VStack {
            List {
                ForEach(searchFoodResult, id: \.self) { foodItem in
                    SearchFoodEntryView(food: foodItem)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.horizontal, 10)
                        .contentShape(Rectangle())// needed because tap gesture ignores Spacers()
                        .onTapGesture {
                            showAddFoodScreen.toggle()
                            self.selectedItem = foodItem
                        }
                        .sheet(isPresented: $showAddFoodScreen) {
                                AddFoodView(foodItem: localSelectedItem.mapToAddFoodUiModel(givenConsumptionTime: navigationBarTitle))
                        }
                }
            }
        }
        .navigationTitle(navigationBarTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create Food") {
                    showCreateFoodScreen.toggle()
                }
            }
        }
        .sheet(isPresented: $showCreateFoodScreen) {
            CreateFoodView()
        }
        .searchable(text: $searchText)
        .onAppear {
            self.viewModel.loadFoods()
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error"), message: Text("Something went wrong"))
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
