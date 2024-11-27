//
//  ToDoTableViewCell+ViewModel.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

extension ToDoTableViewCell {

    struct ViewModel {

        let id: ToDoModel.ToDoID
        let userID: Int
        let title: String
        let description: String
        let date: Date
        let completed: Bool

        let completedHandler: (() -> Void)?
        let onTappedHandler: (() -> Void)?
    }
}
