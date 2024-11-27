//
//  ToDoDetailsAssembly.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

struct ToDoDetailsAssembly {

    let mode: ToDoDetailsInteractor.ToDoDetailsMode

    let dependencies: AppDependencies
}

extension ToDoDetailsAssembly: IModule {

    func makeModule() -> UIViewController {
        let router = ToDoDetailsRouter()
        let interactor = ToDoDetailsInteractor(
            mode: mode,
            toDoRepository: dependencies.repositories.toDoRepository
        )
        let presenter = ToDoDetailsPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = ToDoDetailsViewController(
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
