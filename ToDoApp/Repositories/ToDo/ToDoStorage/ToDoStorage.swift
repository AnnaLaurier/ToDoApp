//
//  ToDoStorage.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class ToDoStorage {

    private let dbRepository: IDBRepository
    private let entityMapper: ToDoStorageEntityMapper

    init(
        dbRepository: IDBRepository,
        entityMapper: ToDoStorageEntityMapper
    ) {
        self.dbRepository = dbRepository
        self.entityMapper = entityMapper
    }
}

extension ToDoStorage: IToDoStorage {

    func fetchAll(
        completionQueue: DispatchQueue,
        completion: @escaping ([ToDoModel]) -> Void
    ) {
        dbRepository.performTask { [weak self] context in
            guard let self else {
                assertionFailure("Self isn't exist")
                completionQueue.async {
                    completion([])
                }
                return
            }

            let request = ToDoMO.fetchRequest()
            do {
                let entities = try self.dbRepository.fetch(
                    request: request,
                    context: context
                )
                let toDoModels = entities.compactMap {
                    self.entityMapper.convert(entity: $0)
                }

                completionQueue.async {
                    completion(toDoModels)
                }
            } catch {
                assertionFailure(error.localizedDescription)
                completionQueue.async {
                    completion([])
                }
            }
        }
    }

    func fetch(
        toDoID: ToDoModel.ToDoID,
        completionQueue: DispatchQueue,
        completion: @escaping (ToDoModel?) -> Void
    ) {
        dbRepository.performTask { [weak self] context in
            guard let self else {
                assertionFailure("Self isn't exist")
                completionQueue.async {
                    completion(nil)
                }
                return
            }

            let request = ToDoMO.fetchRequest()
            request.predicate = NSPredicate(format: "toDoID == %lld", toDoID)
            request.fetchLimit = 1

            do {
                let entities = try self.dbRepository.fetch(request: request, context: context)
                let toDoModel = entities.compactMap {
                    self.entityMapper.convert(entity: $0)
                }

                completionQueue.async {
                    completion(toDoModel.first)
                }
            } catch {
                assertionFailure(error.localizedDescription)
                completionQueue.async {
                    completion(nil)
                }
            }
        }
    }

    func save(
        toDoModel: ToDoModel,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    ) {
        dbRepository.performTask { [weak self] context in
            guard let self else {
                assertionFailure("Self isn't exist")
                completionQueue.async {
                    completion()
                }
                return
            }

            let toDoMO = ToDoMO(context: context)
            self.entityMapper.bind(entity: toDoMO, model: toDoModel)

            do {
                try self.dbRepository.save(context: context)
                completionQueue.async {
                    completion()
                }
            } catch {
                assertionFailure(error.localizedDescription)
                completionQueue.async {
                    completion()
                }
            }
        }
    }

    func delete(
        toDoID: ToDoModel.ToDoID,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    ) {
        dbRepository.performTask { [weak self] context in
            guard let self else {
                assertionFailure("Self isn't exist")
                completionQueue.async {
                    completion()
                }
                return
            }

            do {
                try self.dbRepository.delete(
                    entityMO: ToDoMO.self,
                    predicate: NSPredicate(format: "toDoID == %lld", toDoID),
                    context: context
                )
                try self.dbRepository.save(context: context)
                completionQueue.async {
                    completion()
                }
            } catch {
                assertionFailure(error.localizedDescription)
                completionQueue.async {
                    completion()
                }
            }
        }
    }

    func update(
        toDoModel: ToDoModel,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    ) {
        dbRepository.performTask { [weak self] context in
            guard let self else {
                assertionFailure("Self isn't exist")
                completionQueue.async {
                    completion()
                }
                return
            }

            let toDoMO = ToDoMO(context: context)
            self.entityMapper.bind(entity: toDoMO, model: toDoModel)

            let predicate = NSPredicate(format: "toDoID == %lld", toDoModel.id)

            do {
                try self.dbRepository.delete(
                    entityMO: ToDoMO.self,
                    predicate: predicate,
                    context: context
                )
                try self.dbRepository.save(context: context)
                completionQueue.async {
                    completion()
                }
            } catch {
                assertionFailure(error.localizedDescription)
                completionQueue.async {
                    completion()
                }
            }
        }
    }
}
