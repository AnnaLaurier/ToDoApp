//
//  ToDoDataModel.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

struct ToDoDataModel: Codable {

    let todos: [ToDos]
}

struct ToDos: Codable {

    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
