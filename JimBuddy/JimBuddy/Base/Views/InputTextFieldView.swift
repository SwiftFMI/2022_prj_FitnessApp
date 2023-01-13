//
//  InputTextFieldView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 10.01.23.
//

import SwiftUI

struct InputTextFieldView: View {
    
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding(.horizontal, 20)
            .frame(minHeight: 50)
            .textFieldStyle(.roundedBorder)
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputTextFieldView(text: .constant(""), placeholder: "Email", keyboardType: .emailAddress)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Text Input Field")
            .padding()
    }
}
