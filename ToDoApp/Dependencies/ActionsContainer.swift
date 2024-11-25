//
//  ActionsContainer.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

final class ActionsContainer {

    lazy var preload: IPreloadAction = {
        return PreloadAction(
            toDoRepository: appDependencies.repositories.toDoRepository
        )
    }()

    private let appDependencies: AppDependencies

    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
}
