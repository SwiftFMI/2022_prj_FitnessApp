//
//  LoginModel.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 13.01.23.
//

import SwiftUI

class LoginModel: ObservableObject {
    @Published var emailFieldClicked : Bool = false
    @Published var passwordFieldClicked : Bool = false
}
