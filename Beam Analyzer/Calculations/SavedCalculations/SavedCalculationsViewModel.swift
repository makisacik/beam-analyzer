//
//  SavedCalculationsViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.05.2023.
//

import Foundation

final class SavedCalculationsViewModel {
    var calculations: [CalculationEntity] = []
    
    func fetchCalculations() {
        calculations = CoreDataManager.shared.loadCalculations()
    }
    
    func deleteCalculation(_ calculation: CalculationEntity) {
        CoreDataManager.shared.deleteCalculation(calculation)
    }
    
}
