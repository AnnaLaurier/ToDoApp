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
//        self.toDoStorage.fetchAll(
//            completionQueue: completionQueue,
//            completion: { toDoModels in
//                completion(.success(toDoModels))
//            }
//        )
//
//        toDoService.getToDoList(
//            completionQueue: completionQueue,
//            completion: { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let todos):
//                    todos.forEach { toDo in
//                        let toDoModel = ToDoMappingRule.mapToDoModel(toDo)
//                        self.saveToDo(
//                            toDoModel: toDoModel,
//                            completionQueue: completionQueue,
//                            completion: {
//                                print("Save \(toDoModel.id)")
//                            }
//                        )
//                    }
//
//
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        )
    }

    func fetchToDoDetails() {
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
