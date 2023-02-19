//
//  HealthStat.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 18.02.23.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable {
    let id = UUID()
    let stat: HKQuantity?
    let datea: Date
}
