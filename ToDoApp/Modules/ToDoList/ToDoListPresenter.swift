//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListPresenterInput: AnyObject {

    func viewIsReady()

    func viewWillAppear()

    func editTappedHandler(_ toDoID: ToDoModel.ToDoID)

    func shareTappedHandler(_ toDoID: ToDoModel.ToDoID)

    func deleteTappedHandler(_ toDoID: ToDoModel.ToDoID)

    func onAddTappedHandler()
}

class ToDoListPresenter {

    weak var view: IToDoListViewControllerInput?

    private let interactor: IToDoListInteractorInput
    private let router: IToDoListRouterInput

    private var toDoModels: [ToDoModel] = []
    private var completedTodoIDs: Set<ToDoModel.ToDoID> = []

    init(
        interactor: IToDoListInteractorInput,
        router: IToDoListRouterInput
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension ToDoListPresenter: IToDoListPresenterInput {

    func viewIsReady() {
        fetchList()
    }

    func viewWillAppear() {
        fetchList()
    }

    func editTappedHandler(_ toDoID: ToDoModel.ToDoID) {
        router.openEditDetails(toDoID)
    }

    func shareTappedHandler(_ toDoID: ToDoModel.ToDoID) {
        guard let shareText = toDoModels.first(where: { $0.id == toDoID }) else {
            return
        }

        router.shareDetails([shareText])
    }

    func deleteTappedHandler(_ toDoID: ToDoModel.ToDoID) {
        interactor.delete(toDoID: toDoID) { [weak self] in
            self?.fetchList()
        }
    }

    func onAddTappedHandler() {
        router.openAddDetails()
    }
}

private extension ToDoListPresenter {

    func fetchList() {
        interactor.fetchList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let models):
                self.toDoModels = models
                self.completedTodoIDs = Set(models.compactMap {
                    $0.completed ? $0.id : nil
                })
                self.updateViewModel(models)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

    func updateViewModel(_ models: [ToDoModel]) {
        let viewModels = models.map(mapViewModel)
        view?.reloadData(viewModels: viewModels)
    }

    func mapViewModel(_ model: ToDoModel) -> ToDoTableViewCell.ViewModel {
        return ToDoTableViewCell.ViewModel(
            id: model.id,
            userID: model.userID,
            title: model.title ?? "(Пустой заголовок)",
            description: model.description ?? "(Пустое описание)",
            date: model.date,
            completed: completedTodoIDs.contains(model.id),
            completedHandler: { [weak self] in
                self?.onCompletedHandler(model)
            }, 
            onTappedHandler: { [weak self] in
                self?.router.openEditDetails(model.id)
            }
        )
    }

    func onCompletedHandler(_ model: ToDoModel) {
        if completedTodoIDs.contains(model.id) {
            completedTodoIDs.remove(model.id)
        } else {
            completedTodoIDs.insert(model.id)
        }

        updateViewModel(toDoModels)
    }
}
