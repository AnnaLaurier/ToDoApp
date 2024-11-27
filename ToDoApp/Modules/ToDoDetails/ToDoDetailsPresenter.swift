//
//  ToDoDetailsPresenter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

protocol IToDoDetailsPresenterInput: AnyObject {

    func viewIsReady()

    func updateTitle(_ title: String?)

    func updateDescription(_ description: String?)

    func onReturnTapped()
}

class ToDoDetailsPresenter {

    weak var view: IToDoDetailsViewControllerInput?

    private let interactor: IToDoDetailsInteractorInput
    private let router: IToDoDetailsRouterInput

    private var initialModel: ToDoModel?
    private var title: String?
    private var description: String?

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter
    }()

    init(
        interactor: IToDoDetailsInteractorInput,
        router: IToDoDetailsRouterInput
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension ToDoDetailsPresenter: IToDoDetailsPresenterInput {

    func viewIsReady() {
        setupMode()
    }

    func updateTitle(_ title: String?) {
        self.title = title
    }

    func updateDescription(_ description: String?) {
        self.description = description
    }

    func onReturnTapped() {
        let toDoModel: ToDoModel

        switch interactor.mode {
        case .add:
            guard title != nil || description != nil else { return }

            toDoModel = ToDoModel(
                id: generateUniqueID(),
                userID: generateUniqueID(),
                title: title,
                description: description,
                date: Date(),
                completed: false
            )

            interactor.save(toDoModel: toDoModel, completion: {})
        case .edit(let toDoID):
            guard
                title != initialModel?.title || description != initialModel?.description
            else {
                return
            }

            toDoModel = ToDoModel(
                id: toDoID,
                userID: initialModel?.userID ?? generateUniqueID(),
                title: title,
                description: description,
                date: Date(),
                completed: initialModel?.completed ?? false
            )

            interactor.update(toDoModel: toDoModel, completion: {})
        }
    }
}

private extension ToDoDetailsPresenter {

    func setupMode() {
        let updateCompletion: () -> Void = { [weak self] in
            guard let self else { return }

            self.view?.updateTitle(self.title)
            self.view?.updateDate(self.dateFormatter.string(
                from: self.initialModel?.date ?? Date()
            ))
            self.view?.updateDescription(self.description)
        }

        switch interactor.mode {
        case .add:
            updateCompletion()
        case .edit(let toDoID):
            interactor.fetchDetails(toDoID: toDoID) { [weak self] model in
                guard let model else { return }

                self?.initialModel = model
                self?.title = model.title
                self?.description = model.description

                updateCompletion()
            }
        }
    }

    func generateUniqueID() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
}
