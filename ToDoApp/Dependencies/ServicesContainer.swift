//
//  ServicesContainer.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class ServicesContainer {

    lazy var toDoService: IToDoService = {
        return ToDoService()
    }()
}
