//
//  ToDoMappingRule.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

final class ToDoMappingRule {

    static func mapToDoModel(_ toDo: ToDos) -> ToDoModel {
        return ToDoModel(
            id: toDo.id,
            userID: toDo.userId,
            title: toDo.todo,
            description: toDo.todo,
            date: Date(),
            completed: toDo.completed
        )
    }
}
