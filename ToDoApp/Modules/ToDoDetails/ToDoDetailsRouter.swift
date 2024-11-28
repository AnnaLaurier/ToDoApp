//
//  ToDoDetailsRouter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

protocol IToDoDetailsRouterInput: AnyObject {
}

final class ToDoDetailsRouter {

    weak var viewController: UIViewController?
}

extension ToDoDetailsRouter: IToDoDetailsRouterInput {
}
