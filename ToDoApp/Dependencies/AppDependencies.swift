//
//  AppDependencies.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class AppDependencies {

    lazy var shared = SharedContainer()

    lazy var services = ServicesContainer()

    lazy var storage = StorageContainer()

    lazy var repositories = RepositoriesContainer(
        appDependencies: self
    )

    lazy var coordinators = CoordinatorsContainer(
        appDependencies: self
    )
}
