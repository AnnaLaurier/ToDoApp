//
//  ToDoStorageEntityMapper.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

final class ToDoStorageEntityMapper: IDBEntityMappable {

    typealias Model = ToDoModel
    typealias EntityMO = ToDoMO

    func convert(entity: ToDoMO) -> ToDoModel? {
        guard let date = entity.date else { return nil }

        return ToDoModel(
            id: Int(entity.toDoID),
            userID: Int(entity.userID),
            title: entity.title,
            description: entity.body,
            date: date,
            completed: entity.completed
        )
    }

    func bind(entity: ToDoMO, model: ToDoModel) {
        entity.toDoID = Int64(model.id)
        entity.userID = Int64(model.userID)
        entity.title = model.title
        entity.body = model.description
        entity.date = model.date
        entity.completed = model.completed
    }
}
