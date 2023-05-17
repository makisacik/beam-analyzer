//
//  DeflectionCalculation.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 10.05.2023.
//

import Foundation

final class DeflectionCalculation {
    let inputs: CalculationInputs
    let result: Double
    
    init(inputs: CalculationInputs, result: Double) {
        self.inputs = inputs
        self.result = result
    }
    
    func getMessageText() -> String {
        let text = "Lenght of beam (m): \(inputs.lenght)\nCross-section width (m): \(inputs.width)\nCross-section height (m):  \(inputs.height)\nPoint load (N): \(inputs.pointLoad)\nYoung's modulus (GPa): \(inputs.youngModulus)\n\nValue: \(result)"
        return text
    }
}
