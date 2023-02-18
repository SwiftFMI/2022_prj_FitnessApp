//
//  FirebaseErrors.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 18.02.23.
//

import Foundation

enum FirebaseError: String, Error {
    case generalError = "General error"
    case emptySnapshot = "No data has been found"
    case authError = "Your session has expired, please log in again"
}
