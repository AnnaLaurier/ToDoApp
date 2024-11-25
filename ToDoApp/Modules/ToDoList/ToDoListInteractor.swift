//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListInteractorInput: AnyObject {

    func fetchToDos(
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
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

    func fetchToDos(
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    ) {
        toDoRepository.fetchToDoList(
            completionQueue: .main,
            completion: completion
        )
    }
}
