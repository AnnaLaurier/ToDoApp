//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListInteractorInput: AnyObject,
                                   IToDoSubscribeNotifier {

    func fetchList(
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    )

    func delete(toDoID: ToDoModel.ToDoID)

    func update(toDoModel: ToDoModel)
}

final class ToDoListInteractor {

    private let toDoRepository: IToDoRepository
    private let toDoNotifier: IToDoNotifier

    init(
        toDoRepository: IToDoRepository,
        toDoNotifier: IToDoNotifier
    ) {
        self.toDoRepository = toDoRepository
        self.toDoNotifier = toDoNotifier
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

    func delete(toDoID: ToDoModel.ToDoID) {
        toDoRepository.delete(toDoID: toDoID)
    }

    func update(toDoModel: ToDoModel) {
        toDoRepository.update(toDoModel: toDoModel)
    }
}

extension ToDoListInteractor: IToDoSubscribeNotifier {

    func subscribe(_ listener: IToDoListener) {
        toDoNotifier.subscribe(listener)
    }

    func unsubscribe(_ listener: IToDoListener) {
        toDoNotifier.unsubscribe(listener)
    }
}
