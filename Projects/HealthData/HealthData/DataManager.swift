//
//  DataManager.swift
//  HealthData
//
//  Created by Mark Ashinhust on 4/25/23.
//

import Foundation
import CoreData

// MARK: Begin DataManager Class
class DataManager {
    static let shared = DataManager()
    
    let persistentContainer: NSPersistentContainer
    
    // MARK: Init Methods
    private init() {
        persistentContainer = NSPersistentContainer(name: "HealthData")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: Saving Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Save Health Data
    func saveHealthData(bloodPressure: String, weight: String, sugarLevel: String, date: Date) {
        let context = persistentContainer.viewContext
        let healthData = HealthData(context: context)
        healthData.bloodPressure = bloodPressure
        healthData.weight = weight
        healthData.sugarLevel = sugarLevel
        healthData.date = date
        
        saveContext()
    }
    
    // MARK: Fetch the Health Data
    func fetchHealthData(startDate: Date, endDate: Date) -> [HealthData] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<HealthData> = HealthData.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startDate as NSDate, endDate as NSDate)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
}
