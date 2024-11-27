//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListRouterInput: AnyObject {

    func openAddDetails()

    func openEditDetails(_ toDoID: ToDoModel.ToDoID)

    func shareDetails(_ itemsToShare: [Any])
}

class ToDoListRouter {

    weak var viewController: UIViewController?

    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }
}

extension ToDoListRouter: IToDoListRouterInput {

    func openAddDetails() {
        let toDoDetailsViewController = ToDoDetailsAssembly(
            mode: .add,
            dependencies: dependencies
        ).makeModule()
        toDoDetailsViewController.navigationItem.largeTitleDisplayMode = .never

        viewController?.navigationController?.pushViewController(
            toDoDetailsViewController,
            animated: true
        )
    }

    func openEditDetails(_ toDoID: ToDoModel.ToDoID) {
        let toDoDetailsViewController = ToDoDetailsAssembly(
            mode: .edit(toDoID),
            dependencies: dependencies
        ).makeModule()
        toDoDetailsViewController.navigationItem.largeTitleDisplayMode = .never

        viewController?.navigationController?.pushViewController(
            toDoDetailsViewController,
            animated: true
        )
    }

    func shareDetails(_ itemsToShare: [Any]) {
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )

        viewController?.present(activityViewController, animated: true)
    }
}
