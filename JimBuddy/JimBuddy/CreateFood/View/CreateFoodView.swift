//
//  CreateFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import SwiftUI

struct CreateFoodView: View {
    
    @StateObject private var viewModel = CreateFoodViewModelImpl(service: CreateFoodServiceImpl())
    
    var body: some View {
        VStack(spacing: 16) {
            CreateFoodInputField(text: $viewModel.createFoodDetails.name, labelText: "Name:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.quantity, labelText: "Quantity:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.measuringUnits, labelText: "Measuring Unit:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.calories, labelText: "Calories:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.protein, labelText: "Protein:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.carbs, labelText: "Carbs:")
            CreateFoodInputField(text: $viewModel.createFoodDetails.fats, labelText: "Fats:")
            Spacer()
            ButtonView(title: "Create food") {
                viewModel.createFood()
            }
        }
        .padding(20)
        .navigationTitle("Create food")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.hasError) {
            if case .failed(let error) = viewModel.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        }
    }
}

struct CreateFoodView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateFoodView()
        }
    }
}
