//
//  ToDoDetailsAssembly.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

struct ToDoDetailsAssembly {

    let toDoID: ToDoModel.ToDoID?
}

extension ToDoDetailsAssembly: IModule {

    func makeModule() -> UIViewController {
        let router = ToDoDetailsRouter()
        let interactor = ToDoDetailsInteractor(
            toDoID: toDoID
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
