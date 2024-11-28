//
//  RepositoriesContainer.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class RepositoriesContainer {

    lazy var notifierRepository: INotifierRepository = {
        return NotifierRepository(
            toDoNotifier: ToDoNotifier()
        )
    }()

    lazy var toDoRepository: IToDoRepository = {
        return ToDoRepository(
            toDoService: appDependencies.services.toDoService,
            toDoStorage: appDependencies.storage.toDoStorage,
            toDoNotifier: notifierRepository.toDoNotifier
        )
    }()

    private let appDependencies: AppDependencies

    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
}
