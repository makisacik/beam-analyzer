//
//  DeflectionCalculationUseCase.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 4.05.2023.
//

import Foundation

final class DeflectionCalculationUseCase {
    func calculate(lenght: Double, width: Double, height: Double, pointLoad: Double, youngModulus: Double) -> Double {
        let momentInertia = (width * pow(height, 3)) / 12
        
        let youngModulus = youngModulus * 1_000_000_000
        
        let maximumDeflection = (pointLoad * pow(lenght, 3)) / (3 * youngModulus * momentInertia)
        
        return maximumDeflection
    }
}
