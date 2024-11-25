//
//  IToDoStorage.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

protocol IToDoStorage: AnyObject {

    func fetchAll(
        completionQueue: DispatchQueue,
        completion: @escaping ([ToDoModel]) -> Void
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
}
