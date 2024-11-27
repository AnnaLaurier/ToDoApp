//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListInteractorInput: AnyObject {

    func fetchList(
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    )

    func delete(
        toDoID: ToDoModel.ToDoID,
        completion: @escaping () -> Void
    )
}

class ToDoListInteractor {

    private let toDoRepository: IToDoRepository

    init(
        toDoRepository: IToDoRepository
    ) {
        self.toDoRepository = toDoRepository
    }
}

extension ToDoListInteractor: IToDoListInteractorInput {

    func fetchList(
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    ) {
        toDoRepository.fetchList(
            completionQueue: .main,
            completion: completion
        )
    }

    func delete(
        toDoID: ToDoModel.ToDoID,
        completion: @escaping () -> Void
    ) {
        toDoRepository.delete(
            toDoID: toDoID,
            completionQueue: .main,
            completion: completion
        )
    }
}
