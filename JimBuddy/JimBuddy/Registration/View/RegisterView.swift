//
//  RegisterView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 13.01.23.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var viewModel = RegistrationViewModelImpl(service: RegistrationServiceImpl())
    
    var body: some View {
        NavigationView {
            VStack(spacing:16) {
                Spacer()
                Image("jim_buddy_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                VStack(spacing: 16) {
                    InputTextFieldView(text: $viewModel.userDetails.email, placeholder: "Email", keyboardType: .emailAddress)
                    InputPasswordView(password: $viewModel.userDetails.password, placeholder: "Password")
                    Divider()
                    InputTextFieldView(text: $viewModel.userDetails.firstName, placeholder: "First Name", keyboardType: .namePhonePad)
                    InputTextFieldView(text: $viewModel.userDetails.secondName, placeholder: "Last Name", keyboardType: .namePhonePad)
                }
                Spacer()
                ButtonView(title: "Register") {
                    viewModel.register()
                }.padding(.bottom,20)
            }
            .padding(.horizontal, 20)
            .navigationTitle("Register")
            .addCloseButton()
            .alert(isPresented: $viewModel.hasError) {
                if case .failed(let error) = viewModel.state {
                    return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                } else {
                    return Alert(title: Text("Error"), message: Text("Something went wrong"))
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
