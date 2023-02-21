//
//  Food.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 20.01.23.
//

import Foundation

struct Food: Hashable, Codable {
    var id = UUID()
    var name: String
    var calories: Int
}
