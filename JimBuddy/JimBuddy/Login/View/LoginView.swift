//
//  LoginView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 10.01.23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModelImpl(service: LoginServiceImpl())

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                Text("JimBuddy")
                    .font(.largeTitle)
                    .foregroundColor(Colors.darkGrey)
                Image("jim_buddy_no_bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Spacer()

                InputTextFieldView(text: $viewModel.credentials.email,
                                   placeholder: "Email",
                                   keyboardType: .emailAddress)
                InputPasswordView(password: $viewModel.credentials.password,
                                  placeholder: "Password")

                Divider()

                ButtonView(title: "Login") {
                    viewModel.login()
                }

                NavigationLink(destination: RegisterView()) {
                    ButtonView(title: "Sign up",
                               background: .clear,
                               foreground: Colors.darkGrey,
                               border: Colors.darkGrey,
                               handler: { /* empty closure */ })
                }
            }
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
