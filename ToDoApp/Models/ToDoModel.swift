//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import Foundation

struct ToDoModel: Codable {

    typealias ToDoID = Int

    let id: ToDoID
    let userID: Int
    let title: String?
    let description: String?
    let date: Date
    let completed: Bool
}
