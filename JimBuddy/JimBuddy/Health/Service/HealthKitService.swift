//
//  HealthKitService.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 18.02.23.
//

import Foundation
import HealthKit

class HealthKitService {
    let healthStore: HKHealthStore

    var query: HKStatisticsCollectionQuery? = nil

    init() {
        healthStore = HKHealthStore()
    }

    func requestPermission(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable(),
              let gender = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
              let birthday = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
              let weight = HKObjectType.quantityType(forIdentifier: .bodyMass),
              let height = HKObjectType.quantityType(forIdentifier: .height),
              let energyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
              let exerciseTime = HKObjectType.quantityType(forIdentifier: .appleExerciseTime),
              let moveDistance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
              let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false)
            return
        }
        let readTypes = [height, weight, gender, birthday, energyBurned, exerciseTime, moveDistance, stepCount]

        healthStore.requestAuthorization(toShare: [], read: Set(readTypes), completion: { result, _ in
            completion(result)
        })
    }
}
