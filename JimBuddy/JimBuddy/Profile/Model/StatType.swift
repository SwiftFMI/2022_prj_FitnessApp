//
//  StatTypes.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation
import HealthKit

enum StatType: Comparable {
    case height
    case bodyWeight
    case steps
    case moveDistance
    case caloriesBurned
    case exerciseTime

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

    static let allTypes: [StatType: HKSampleType?] = [.steps: HKSampleType.quantityType(forIdentifier: .stepCount),
                                                      .height: HKSampleType.quantityType(forIdentifier: .height),
                                                      .bodyWeight: HKSampleType.quantityType(forIdentifier: .bodyMass),
                                                      .caloriesBurned: HKSampleType.quantityType(forIdentifier: .activeEnergyBurned),
                                                      .exerciseTime: HKSampleType.quantityType(forIdentifier: .appleExerciseTime),
                                                      .moveDistance: HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)]
}
