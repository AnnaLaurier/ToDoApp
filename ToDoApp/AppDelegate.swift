//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var dependencies = AppDependencies()

    private lazy var rootCoordinator = dependencies.coordinators.root
    private lazy var preloadAction = dependencies.actions.preload

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        #if DEBUG
        print(
            "DocumentDir:",
            FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).last ?? "Not Found!"
        )
        #endif

        preloadAction.execute(completionQueue: .main) { [weak self] in
            self?.rootCoordinator.openToDoList()
        }

        return true
    }
}
