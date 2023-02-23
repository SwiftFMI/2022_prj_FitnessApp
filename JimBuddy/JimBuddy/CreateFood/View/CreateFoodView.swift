//
//  CreateFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import SwiftUI

struct CreateFoodView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CreateFoodViewModelImpl(service: CreateFoodServiceImpl())
    @State private var selectedItem = MeasuringUnits.gram
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.name)
                }
                Section(header: Text("Quantity")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.quantity)
                }
                Picker("Measuring Units", selection: $viewModel.createFoodDetails.measuringUnits) {
                    ForEach(MeasuringUnits.allCases, id: \.self) { unit in
                        Text(unit.rawValue.capitalized)
                    }
                }
                Section(header: Text("Calories")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.calories)
                }
                Section(header: Text("Protein")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.protein)
                }
                Section(header: Text("Carbs")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.carbs)
                }
                Section(header: Text("Fats")) {
                    CreateFoodInputField(text: $viewModel.createFoodDetails.fats)
                }
            }
        }
        .navigationTitle("Create food")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.viewModel.createFood()
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }.foregroundColor(.black)
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            if case .failed(let error) = viewModel.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        }
    }
}

