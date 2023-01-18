//
//  LoginCredentials.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 17.01.23.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials{
    
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
