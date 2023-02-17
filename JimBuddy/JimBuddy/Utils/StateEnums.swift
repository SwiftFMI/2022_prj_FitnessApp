//
//  StateEnums.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 5.02.23.
//

import Foundation

enum ScreenState {
    case successful
    case failed(error: Error)
    case loading
}
