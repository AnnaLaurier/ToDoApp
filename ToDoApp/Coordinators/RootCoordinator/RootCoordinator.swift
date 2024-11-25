//
//  RootCoordinator.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

final class RootCoordinator {

    private let window: UIWindow
    private let dependencies: AppDependencies

    init(
        window: UIWindow,
        dependencies: AppDependencies
    ) {
        self.window = window
        self.dependencies = dependencies
    }
}

extension RootCoordinator: IRootCoordinator {

    func openToDoList() {
        let viewController = ToDoListAssembly(
            dependencies: dependencies
        )
            .makeModule()

        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        navigationController.navigationBar.prefersLargeTitles = true

        updateWindow(navigationController)
    }
}

private extension RootCoordinator {

    func updateWindow(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
