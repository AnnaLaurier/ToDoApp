//
//  StorageContainer.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class StorageContainer {

    lazy var toDoStorage: IToDoStorage = {
        return ToDoStorage(
            dbRepository: dbRepository,
            entityMapper: ToDoStorageEntityMapper()
        )
    }()

    private lazy var dbContextProvider: IDBContextProvidable = {
        return DBContextProvider(containerName: "ToDo")
    }()

    private lazy var dbRepository: IDBRepository = {
        return DBRepository(contextProvidable: dbContextProvider)
    }()
}
