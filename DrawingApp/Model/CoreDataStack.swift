//
//  CoreDataStack.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-27.
//

import Foundation

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    private let persistentContainer: NSPersistentContainer
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "DrawingModel")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                print(error)
            }
        })
    }
    
    func save() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    static var preview: CoreDataStack = {
        let coreDataStack = CoreDataStack(inMemory: true)
        coreDataStack.save()
        return coreDataStack
    }()
}
