//
//  CoordinatorsContainer.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class CoordinatorsContainer {

    private let appDependencies: AppDependencies

    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }

    lazy var root: IRootCoordinator = {
        return RootCoordinator(
            window: appDependencies.shared.window,
            dependencies: appDependencies
        )
    }()
}
