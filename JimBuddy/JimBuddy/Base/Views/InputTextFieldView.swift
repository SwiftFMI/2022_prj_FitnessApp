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
    
    private let textFieldLeadingPadding: CGFloat = 15
    
    var body: some View {
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(.leading, 10)
            .autocorrectionDisabled(true)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 2)
                    .background(RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white))
            )
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputTextFieldView(text: .constant(""), placeholder: "Email", keyboardType: .emailAddress)
    }
}
