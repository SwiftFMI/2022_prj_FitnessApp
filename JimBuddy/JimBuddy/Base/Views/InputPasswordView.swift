//
//  InputPasswordView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 10.01.23.
//

import SwiftUI

struct InputPasswordView: View {
    @Binding var password: String
    let placeholder: String
    
    var body: some View {
        SecureField(placeholder, text: $password)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(.leading, 10)
            .autocorrectionDisabled(true)
            .background(
                VStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.gray, lineWidth: 4)
                }
            )
    }
}

struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordView(password: .constant(""), placeholder: "Password")
    }
}
