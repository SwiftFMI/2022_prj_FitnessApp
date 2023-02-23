//
//  CreateFoodInputField.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 21.01.23.
//

import SwiftUI

struct CreateFoodInputField: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Required", text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
        }
    }
}

struct CreateFoodInputField_Previews: PreviewProvider {
    static var previews: some View {
        CreateFoodInputField(text: .constant(""))
    }
}
