//
//  CoreDataManager.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.05.2023.
//
// swiftlint:disable force_cast

import UIKit
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error on saving data \(error)")
        }
    }
    
    func saveCalculation(_ calculation: DeflectionCalculation) -> CalculationEntity {
        let entity = CalculationEntity(context: context)
        entity.height = calculation.inputs.height
        entity.lenght = calculation.inputs.lenght
        entity.width = calculation.inputs.width
        entity.pointLoad = calculation.inputs.youngModulus
        entity.youngModulus = calculation.inputs.youngModulus
        entity.result = calculation.result
        entity.date = Date()
        saveContext()
        
        return entity
    }
    
    func loadCalculations() -> [CalculationEntity] {
        let request: NSFetchRequest<CalculationEntity> = CalculationEntity.fetchRequest()
        do {
            let calculations = try context.fetch(request)
            return calculations
        } catch {
            print("Error fetching data  \(error)")
            return [CalculationEntity]()
        }
    }
    
    func deleteCalculation(_ calculation: CalculationEntity) {
        context.delete(calculation)
        saveContext()
    }
}
