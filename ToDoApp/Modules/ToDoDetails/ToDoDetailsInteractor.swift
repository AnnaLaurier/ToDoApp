//
//  ToDoDetailsInteractor.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

protocol IToDoDetailsInteractorInput: AnyObject {

    var mode: ToDoDetailsInteractor.ToDoDetailsMode { get }

    func fetchDetails(
        toDoID: ToDoModel.ToDoID,
        completion: @escaping (ToDoModel?) -> Void
    )

    func save(toDoModel: ToDoModel)

    func update(toDoModel: ToDoModel)
}

final class ToDoDetailsInteractor {

    var mode: ToDoDetailsMode

    private let toDoRepository: IToDoRepository

    init(
        mode: ToDoDetailsMode,
        toDoRepository: IToDoRepository
    ) {
        self.mode = mode
        self.toDoRepository = toDoRepository
    }
}

extension ToDoDetailsInteractor: IToDoDetailsInteractorInput {

    func fetchDetails(
        toDoID: ToDoModel.ToDoID,
        completion: @escaping (ToDoModel?) -> Void
    ) {
        toDoRepository.fetch(
            toDoID: toDoID,
            completionQueue: .main,
            completion: completion
        )
    }

    func save(toDoModel: ToDoModel) {
        toDoRepository.save(toDoModel: toDoModel)
    }

    func update(toDoModel: ToDoModel) {
        toDoRepository.update(toDoModel: toDoModel)
    }
}

extension ToDoDetailsInteractor {

    enum ToDoDetailsMode {

        case add
        case edit(ToDoModel.ToDoID)
    }
}
