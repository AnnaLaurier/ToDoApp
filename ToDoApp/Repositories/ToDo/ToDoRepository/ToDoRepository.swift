//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

class ToDoRepository {

    private let toDoService: IToDoService
    private let toDoStorage: IToDoStorage

    init(
        toDoService: IToDoService,
        toDoStorage: IToDoStorage
    ) {
        self.toDoService = toDoService
        self.toDoStorage = toDoStorage
    }
}

extension ToDoRepository: IToDoRepository {

    func fetchToDoList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    ) {
        toDoStorage.fetchAll(
            completionQueue: completionQueue,
            completion: { toDoModels in
                completion(.success(toDoModels))
            }
        )
    }

    func preload(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        toDoService.getToDoList(
            completionQueue: completionQueue,
            completion: { [weak self] result in
                guard let self else { return }

                switch result {
                case .success(let todos):
                    let dispatchGroup = DispatchGroup()

                    for toDo in todos {
                        dispatchGroup.enter()

                        let toDoModel = ToDoMappingRule.mapToDoModel(toDo)
                        self.saveToDo(
                            toDoModel: toDoModel,
                            completionQueue: completionQueue,
                            completion: {
                                dispatchGroup.leave()
                            }
                        )
                    }

                    dispatchGroup.notify(queue: completionQueue) {
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}

private extension ToDoRepository {

    func saveToDo(
        toDoModel: ToDoModel,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    ) {
        toDoStorage.save(
            toDoModel: toDoModel,
            completionQueue: completionQueue,
            completion: completion
        )
    }
}
