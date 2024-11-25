//
//  ToDoDetailsInteractor.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

protocol IToDoDetailsInteractorInput: AnyObject {
}

class ToDoDetailsInteractor {

    private let toDoID: ToDoModel.ToDoID?

    init(toDoID: ToDoModel.ToDoID?) {
        self.toDoID = toDoID
    }
}

extension ToDoDetailsInteractor: IToDoDetailsInteractorInput {
}
