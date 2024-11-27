//
//  IToDoRepository.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

protocol IToDoRepository: AnyObject {

    func fetchList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    )

    func fetch(
        toDoID: ToDoModel.ToDoID,
        completionQueue: DispatchQueue,
        completion: @escaping (ToDoModel?) -> Void
    )

    func save(
        toDoModel: ToDoModel,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    )

    func delete(
        toDoID: ToDoModel.ToDoID,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    )

    func update(
        toDoModel: ToDoModel,
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    )

    func preload(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}
