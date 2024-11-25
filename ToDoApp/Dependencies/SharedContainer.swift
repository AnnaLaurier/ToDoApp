//
//  SharedContainer.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

final class SharedContainer {

    lazy var window: UIWindow = {
        UIWindow(frame: UIScreen.main.bounds)
    }()
}
