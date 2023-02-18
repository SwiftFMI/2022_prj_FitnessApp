//
//  AddFoodButtonView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 18.02.23.
//

import SwiftUI

struct AddFoodView: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(Colors.green)
            Text("Add Food")
                .foregroundColor(Colors.green)
                .font(.caption)
            Spacer()
        }
    }
}

struct AddFoodButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
