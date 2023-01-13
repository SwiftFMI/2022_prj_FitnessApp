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
            .textFieldStyle(.roundedBorder)
            .frame(minHeight: 50)
            .padding(.horizontal, 20)
    }
}

struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordView(password: .constant(""), placeholder: "Password")
    }
}
