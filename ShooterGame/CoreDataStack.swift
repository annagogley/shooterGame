//
//  CoreDataStack.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 19.09.2023.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack(modelName: "StatisticsCoreData")
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
        
    func deleteData(data: Statistics) {
        managedContext.delete(data)
        saveContext()
    }
    
    func getAllStat() -> [Statistics] {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    var isEmpty: Bool {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistics")
            let count  = try managedContext.count(for: request)
            return count == 0
        } catch {
            return true
        }
    }
    
    func updateData(userScore: Double, shotScore: Double, accuracyScore: Double, date: String) {
        let newData = Statistics(context: managedContext)
        newData.userScore = userScore
        newData.shotScore = shotScore
        newData.accuracyScore = accuracyScore
        newData.date = date
        saveContext()
    }
}
