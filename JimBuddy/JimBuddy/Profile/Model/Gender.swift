//
//  Gender.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case other = "Other"

    var iconName: String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        case .other:
            return "other_gender"
        }
    }
}
