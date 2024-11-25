//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListRouterInput: AnyObject {

    func openDetails(_ todoID: ToDoModel.ToDoID)

    func shareDetails(_ itemsToShare: [Any])
}

class ToDoListRouter {

    weak var viewController: UIViewController?
}

extension ToDoListRouter: IToDoListRouterInput {

    func openDetails(_ todoID: ToDoModel.ToDoID) {
        let toDoDetailsViewController = ToDoDetailsAssembly(
            toDoID: todoID
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
