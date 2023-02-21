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
            VStack() {
                Spacer()
                ScrollView {
                    Text("JimBuddy")
                        .font(.largeTitle)
                        .foregroundColor(Colors.darkGrey)
                    Image("jim_buddy_no_bg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)

                    VStack(spacing: 16) {
                        InputTextFieldView(text: $viewModel.userDetails.email, placeholder: "Email", keyboardType: .emailAddress)
                        InputPasswordView(password: $viewModel.userDetails.password, placeholder: "Password")
                        Divider()
                        InputTextFieldView(text: $viewModel.userDetails.firstName, placeholder: "First Name", keyboardType: .namePhonePad)
                        InputTextFieldView(text: $viewModel.userDetails.secondName, placeholder: "Last Name", keyboardType: .namePhonePad)
                    }
                }

                Spacer()

                ButtonView(title: "Sign up") {
                    viewModel.register()
                }.padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $viewModel.hasError) {
                if case .failed(let error) = viewModel.state {
                    return Alert(title: Text("Error"), message: Text(error.localizedDescription))
                } else {
                    return Alert(title: Text("Error"), message: Text("Something went wrong"))
                }
            }.background(Colors.lightGreen)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
