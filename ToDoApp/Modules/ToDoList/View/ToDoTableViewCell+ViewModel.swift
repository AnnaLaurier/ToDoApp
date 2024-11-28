//
//  ToDoTableViewCell+ViewModel.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation
import DifferenceKit

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

extension ToDoTableViewCell.ViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userID)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(date)
        hasher.combine(completed)
    }
}

extension ToDoTableViewCell.ViewModel: Equatable {

    static func == (
        lhs: ToDoTableViewCell.ViewModel,
        rhs: ToDoTableViewCell.ViewModel
    ) -> Bool {
        return lhs.id == rhs.id
        && lhs.userID == rhs.userID
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.date == rhs.date
        && lhs.completed == rhs.completed
    }
}

extension ToDoTableViewCell.ViewModel: Differentiable {

    typealias DifferenceIdentifier = String

    var differenceIdentifier: String {
        return String(id)
    }

    func isContentEqual(to source: ToDoTableViewCell.ViewModel) -> Bool {
        return hashValue == source.hashValue
    }
}
