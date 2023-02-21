//
//  APIError.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case invalidUrl
    case otherProblem
}

