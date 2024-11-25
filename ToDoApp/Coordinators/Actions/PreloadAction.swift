//
//  PreloadAction.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

protocol IPreloadAction: AnyObject {

    func execute(
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    )
}

final class PreloadAction {

    private let preloadFlagsStorage = PreloadFlagsStorage()
    private let toDoRepository: IToDoRepository

    init(toDoRepository: IToDoRepository) {
        self.toDoRepository = toDoRepository
    }
}

extension PreloadAction: IPreloadAction {

    func execute(
        completionQueue: DispatchQueue,
        completion: @escaping () -> Void
    ) {
        guard !preloadFlagsStorage.getFlag(.toDoAPILoaded) else {
            completionQueue.async { completion() }
            return
        }

        toDoRepository.preload(
            completionQueue: completionQueue,
            completion: { [weak self] result in
                switch result {
                case .success:
                    self?.preloadFlagsStorage.setFlag(.toDoAPILoaded, newValue: true)
                case .failure(let error):
                    print("Error downloads todos API:", error.localizedDescription)
                    self?.preloadFlagsStorage.setFlag(.toDoAPILoaded, newValue: false)
                }

                completionQueue.async { completion() }
            }
        )
    }
}
