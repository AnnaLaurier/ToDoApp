//
//  IDBRepository.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation
import CoreData

protocol IDBRepository: AnyObject {

    func performTask(completion: @escaping (NSManagedObjectContext) -> Void)

    func save(context: NSManagedObjectContext) throws

    func fetch<EntityMO: NSManagedObject>(
        request: NSFetchRequest<EntityMO>,
        context: NSManagedObjectContext
    ) throws -> [EntityMO] where EntityMO: NSFetchRequestResult

    func delete<EntityMO: NSManagedObject>(
        entityMO: EntityMO.Type,
        predicate: NSPredicate?,
        context: NSManagedObjectContext
    ) throws
}
