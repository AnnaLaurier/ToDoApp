//
//  DBContextProvider.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation
import CoreData

protocol IDBContextProvidable: AnyObject {

    var mainContext: NSManagedObjectContext { get }

    func backgroundContextPerform(completion: @escaping (NSManagedObjectContext) -> Void)

    func backgroundContextPerformAndWait(completion: @escaping (NSManagedObjectContext) -> Void)
}

final class DBContextProvider {

    private let persistentContainer: NSPersistentContainer

    private let internalMainContext: NSManagedObjectContext

    private var managedObjectModel: NSManagedObjectModel {
        return persistentContainer.managedObjectModel
    }

    init(containerName: String) {
        persistentContainer = DBContextProvider.loadPersistentContainer(containerName)
        internalMainContext = persistentContainer.viewContext
    }
}

extension DBContextProvider: IDBContextProvidable {

    var mainContext: NSManagedObjectContext {
        return internalMainContext
    }

    func backgroundContextPerform(completion: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(completion)
    }

    func backgroundContextPerformAndWait(completion: @escaping (NSManagedObjectContext) -> Void) {
        let context = persistentContainer.newBackgroundContext()

        context.performAndWait {
            completion(context)
        }
    }
}

private extension DBContextProvider {

    static func loadPersistentContainer(_ containerName: String) -> NSPersistentContainer {
        guard
            let modelURL = Bundle.main.url(forResource: containerName, withExtension: ".momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            fatalError("Model wasn't found")
        }

        let container = NSPersistentContainer(name: containerName, managedObjectModel: model)

        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            container.viewContext.automaticallyMergesChangesFromParent = true
        }

        return container
    }
}
