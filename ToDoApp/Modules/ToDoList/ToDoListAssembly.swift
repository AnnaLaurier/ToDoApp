//
//  ToDoListAssembly.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

struct ToDoListAssembly {

    let dependencies: AppDependencies
}

extension ToDoListAssembly: IModule {

    func makeModule() -> UIViewController {
        let router = ToDoListRouter(
            dependencies: dependencies
        )
        let interactor = ToDoListInteractor(
            toDoRepository: dependencies.repositories.toDoRepository,
            toDoNotifier: dependencies.repositories.notifierRepository.toDoNotifier
        )
        let presenter = ToDoListPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = ToDoListViewController(
            presenter: presenter
        )

        presenter.view = viewController
        router.viewController = viewController

        defer {
            presenter.viewIsReady()
        }

        return viewController
    }
}
