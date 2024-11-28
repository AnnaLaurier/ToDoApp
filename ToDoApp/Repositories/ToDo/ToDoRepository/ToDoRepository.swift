//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

final class ToDoRepository {

    private let toDoService: IToDoService
    private let toDoStorage: IToDoStorage
    private let toDoNotifier: IToDoNotifier

    private let workQueue = DispatchQueue(
        label: DispatchQueueLabel.create(system: "ToDoRepository")
    )

    init(
        toDoService: IToDoService,
        toDoStorage: IToDoStorage,
        toDoNotifier: IToDoNotifier
    ) {
        self.toDoService = toDoService
        self.toDoStorage = toDoStorage
        self.toDoNotifier = toDoNotifier
    }
}

extension ToDoRepository: IToDoRepository {

    func fetchList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    ) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoStorage.fetchAll(
                completionQueue: completionQueue,
                completion: { toDoModels in
                    completion(.success(toDoModels))
                }
            )
        }

    }

    func fetch(
        toDoID: ToDoModel.ToDoID,
        completionQueue: DispatchQueue,
        completion: @escaping (ToDoModel?) -> Void
    ) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoStorage.fetch(
                toDoID: toDoID,
                completionQueue: completionQueue,
                completion: completion
            )
        }
    }

    func save(toDoModel: ToDoModel) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoStorage.save(
                toDoModel: toDoModel,
                completionQueue: workQueue,
                completion: { [weak self] in
                    self?.toDoNotifier.notify { $0?.didAdd(toDoModel) }
                }
            )
        }
    }

    func delete(toDoID: ToDoModel.ToDoID) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoStorage.delete(
                toDoID: toDoID,
                completionQueue: workQueue,
                completion: { [weak self] in
                    self?.toDoNotifier.notify { $0?.didDelete(toDoID) }
                }
            )
        }
    }

    func update(toDoModel: ToDoModel) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoStorage.update(
                toDoModel: toDoModel,
                completionQueue: workQueue,
                completion: { [weak self] in
                    self?.toDoNotifier.notify { $0?.didUpdate(toDoModel) }
                }
            )
        }
    }

    func preload(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        workQueue.async { [weak self] in
            guard let self else { return }

            self.toDoService.getToDoList(
                completionQueue: completionQueue,
                completion: { [weak self] result in
                    guard let self else { return }

                    switch result {
                    case .success(let todos):
                        let dispatchGroup = DispatchGroup()

                        for toDo in todos {
                            dispatchGroup.enter()

                            let toDoModel = ToDoMappingRule.mapToDoModel(toDo)
                            self.toDoStorage.save(
                                toDoModel: toDoModel,
                                completionQueue: self.workQueue,
                                completion: {
                                    dispatchGroup.leave()
                                }
                            )
                        }

                        dispatchGroup.notify(queue: completionQueue) {
                            completion(.success(()))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            )
        }
    }
}
