//
//  NotifierRepository.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

final class NotifierRepository: INotifierRepository {

    let toDoNotifier: IToDoNotifier

    init(
        toDoNotifier: IToDoNotifier
    ) {
        self.toDoNotifier = toDoNotifier
    }
}
