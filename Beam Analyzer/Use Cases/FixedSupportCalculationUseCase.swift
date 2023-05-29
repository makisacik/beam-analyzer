//
//  FixedSupportCalculationUseCase.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 29.05.2023.
//

import Foundation

final class FixedSupportCalculationUseCase {
    func calculate(inputs: CalculationInputs) -> DeflectionCalculation {
        let momentInertia = (inputs.width * pow(inputs.height, 3)) / 12
        
        let youngModulus = inputs.youngModulus * 1_000_000_000
        
        let maximumDeflectionInMeters = (inputs.pointLoad * pow(inputs.lenght, 3)) / (48 * youngModulus * momentInertia) * 1000
        
        let deflectionCalculation = DeflectionCalculation(inputs: inputs, result: maximumDeflectionInMeters, type: .other)
        
        return deflectionCalculation
    }
}
