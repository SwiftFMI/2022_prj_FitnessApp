//
//  AddFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 22.02.23.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.presentationMode) var presentationMode
    let foodItem: AddFoodUiModel
    @StateObject private var viewModel = AddFoodViewModel(service: AddFoodService())
    
    var body: some View {
        VStack {
            Text(foodItem.name)
                .fontWeight(.bold)
                .font(.title)
            Divider()
            AddFoodItemView(propertyName: "Calories", value: String(foodItem.calories))
            HStack {
                Text("Quantity")
                Spacer()
                TextField("Required", text: $viewModel.quantity)
            }
            AddFoodItemView(propertyName: "Measuring Unit", value: foodItem.measuringUnit.rawValue)
            AddFoodItemView(propertyName: "Consumption Time", value: foodItem.consumptionTime)
            HStack {
                MacrosItemView(macrosName: "Protein", macrosValue: String(foodItem.protein))
                Spacer()
                MacrosItemView(macrosName: "Carbs", macrosValue: String(foodItem.carbs))
                Spacer()
                MacrosItemView(macrosName: "Fats", macrosValue: String(foodItem.fats))
            }.padding(.horizontal, 30)
            Spacer()
        }
        .navigationTitle("Add food")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.viewModel.addFood(addFoodUiModel: foodItem)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }.foregroundColor(.black)
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(foodItem: AddFoodUiModel(name: "Chicken", calories: 150, measuringUnit: .gram, consumptionTime: "Breakfast", protein: 150, carbs: 12, fats: 1))
    }
}
