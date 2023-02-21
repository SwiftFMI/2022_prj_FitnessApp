//
//  AddFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import SwiftUI

struct SearchFoodView: View {
    private let navigationBarTitle : String = "Search Food"
    @StateObject private var viewModel = SearchFoodViewModelImpl(service: SearchFoodService())
    
    var body: some View {
            VStack {
                List {
                    ForEach(viewModel.foods.indices, id: \.self) { idx in
                        SearchFoodEntryView(food: self.$viewModel.foods[idx])
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .padding(.horizontal, 10)
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
            .onAppear {
                self.viewModel.loadFoods()
            }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchFoodView()
        }
    }
}
