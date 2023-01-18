//
//  RegistrationDetails.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 14.01.23.
//

import Foundation

struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var secondName: String
}

extension RegistrationDetails {
    
    static var new: RegistrationDetails {
        RegistrationDetails(email: "", password: "", firstName: "", secondName: "")
    }
}
