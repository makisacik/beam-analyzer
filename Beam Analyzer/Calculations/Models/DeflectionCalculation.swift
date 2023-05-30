//
//  DeflectionCalculation.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 10.05.2023.
//

import Foundation

enum CalculationType: Codable, CaseIterable {
    case freeEnd
    case fixed
    case roller
    case simply
}

final class DeflectionCalculation: Codable {
    let inputs: CalculationInputs
    let result: Double
    let type: CalculationType
    
    init(inputs: CalculationInputs, result: Double, type: CalculationType) {
        self.inputs = inputs
        self.result = result
        self.type = type
    }
}
