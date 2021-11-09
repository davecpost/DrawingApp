//
//  CoreDataStack.swift
//  DrawingApp
//
//  Created by David Post on 2021-10-27.
//

import Foundation

import Foundation
import CoreData
import UIKit
import PencilKit

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
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    static var preview: CoreDataStack = {
        let coreDataStack = CoreDataStack(inMemory: true)
        DrawingEntity.insert(in: coreDataStack.managedObjectContext, name: "Hello", drawing: PKDrawing())
        coreDataStack.save()
        return coreDataStack
    }()
}
