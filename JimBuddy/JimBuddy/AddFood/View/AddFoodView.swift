//
//  AddFoodView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 22.02.23.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.dismiss) private var dismiss
    let foodItem: AddFoodUiModel
    @StateObject private var viewModel = AddFoodViewModel(service: AddFoodService())

    var body: some View {
        NavigationView {
            List {
                VStack {
                    Text(foodItem.name)
                        .fontWeight(.bold)
                        .font(.title)
                    Divider()
                    AddFoodItemView(propertyName: "Calories", value: String(foodItem.calories))

                    AddFoodItemView(propertyName: "Measuring Unit", value: foodItem.measuringUnit.rawValue)

                    AddFoodItemView(propertyName: "Consumption Time", value: foodItem.consumptionTime)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Quantity")
                            .font(.callout)
                            .textCase(.uppercase)
                            .padding(.bottom, 0)
                            .foregroundColor(Colors.darkGrey)
                        TextField("Required", text: $viewModel.quantity)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.leading, 10)
                            .padding(.top, 0)
                            .autocorrectionDisabled(true)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Colors.lightGrey, lineWidth: 1))
                    }
                    .padding(.top, 10)

                    VStack {
                        Text("Macros")
                        .font(.callout)
                        .textCase(.uppercase)
                        .padding(.bottom, 0)
                        .foregroundColor(Colors.lightGrey)
                        HStack {
                            MacrosItemView(macros: .protein, macrosValue: String(foodItem.protein))
                            Spacer()
                            MacrosItemView(macros: .carb, macrosValue: String(foodItem.carbs))
                            Spacer()
                            MacrosItemView(macros: .fat, macrosValue: String(foodItem.fats))
                        }
                    }

                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
                .listRowSeparator(.hidden)
            }.listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.viewModel.addFood(addFoodUiModel: foodItem)
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }.foregroundColor(.black)
                    }

                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "multiply")
                        }.foregroundColor(.black)
                    }
                }
                .alert(isPresented: $viewModel.hasError) {
                    Alert(title: Text("Error"), message: Text("Something went wrong"))
                }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(foodItem: AddFoodUiModel(name: "Chicken", calories: 150, measuringUnit: .gram, consumptionTime: "Breakfast", protein: 150, carbs: 12, fats: 1))
    }
}
