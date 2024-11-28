//
//  IToDoListener.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

protocol IToDoListener: AnyObject {

    func didAdd(_ toDoModel: ToDoModel)

    func didDelete(_ toDoID: ToDoModel.ToDoID)

    func didUpdate(_ toDoModel: ToDoModel)
}
