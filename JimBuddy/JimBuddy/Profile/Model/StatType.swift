//
//  StatTypes.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation

enum StatType {
    case steps
    case caloriesBurned
    case bodyWeight
    case height
    case exerciseTime
    case moveDistance

    var statIconName: String {
        switch self {
        case .steps:
            return "shoeprints.fill"
        case .caloriesBurned:
            return "flame"
        case .bodyWeight:
            return "scalemass"
        case .height:
            return "figure.stand"
        case .exerciseTime:
            return "clock"
        case .moveDistance:
            return "figure.walk"
        }
    }

    var statName: String {
        switch self {
        case .steps:
            return "Steps"
        case .caloriesBurned:
            return "Calories burned"
        case .bodyWeight:
            return "Weight"
        case .height:
            return "Height"
        case .exerciseTime:
            return "Excercise time"
        case .moveDistance:
            return "Distance traveled"
        }
    }
}
