//
//  DateExtension.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 16.02.23.
//

import Foundation

public extension Date {
    static var firebaseCurrentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: Date.now)
    }
}
