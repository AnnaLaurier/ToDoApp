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

    func save(toDoModel: ToDoModel)

    func delete(toDoID: ToDoModel.ToDoID)

    func update(toDoModel: ToDoModel)

    func preload(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}
