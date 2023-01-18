//
//  LoginView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 10.01.23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var showRegisterScreen = false
    @StateObject private var viewModel = LoginViewModelImpl(service: LoginServiceImpl())
    
    var body: some View {
        VStack {
            Spacer()
            Image("jim_buddy_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Spacer()
            VStack(spacing: 16) {
                InputTextFieldView(text: $viewModel.credentials.email, placeholder: "Email", keyboardType: .emailAddress)
                InputPasswordView(password: $viewModel.credentials.password,  placeholder: "Password")
            }
            Spacer()
            VStack(spacing: 16) {
                ButtonView(title: "Login") {
                    viewModel.login()
                }
                ButtonView(title: "Register", background: .clear, foreground: Color(hex: hexForBlackColor), border: Color(hex: hexForLightGreenColor)) {
                    showRegisterScreen.toggle()
                }.sheet(isPresented: $showRegisterScreen) {
                    RegisterView()
                }
            }.padding(.bottom,20)
        }
        .padding(.horizontal, 20)
        .navigationTitle("Login")
        .alert(isPresented: $viewModel.hasError) {
            if case .failed(let error) = viewModel.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
