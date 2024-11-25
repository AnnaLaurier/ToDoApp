//
//  DBRepository.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation
import CoreData

final class DBRepository {

    private let contextProvidable: IDBContextProvidable

    init(contextProvidable: IDBContextProvidable) {
        self.contextProvidable = contextProvidable
    }
}

extension DBRepository: IDBRepository {

    func performTask(completion: @escaping (NSManagedObjectContext) -> Void) {
        contextProvidable.backgroundContextPerform { context in
            completion(context)
        }
    }

    func save(context: NSManagedObjectContext) throws {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        if context.hasChanges {
            try context.save()
        }
    }

    func fetch<EntityMO>(
        request: NSFetchRequest<EntityMO>,
        context: NSManagedObjectContext
    ) throws -> [EntityMO] where EntityMO: NSManagedObject {
        try context.fetch(request)
    }

    func delete<EntityMO>(
        entityMO: EntityMO.Type,
        predicate: NSPredicate?,
        context: NSManagedObjectContext
    ) throws where EntityMO: NSManagedObject {
        let fetchRequest = entityMO.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.includesPropertyValues = false

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(batchDeleteRequest)
    }
}
