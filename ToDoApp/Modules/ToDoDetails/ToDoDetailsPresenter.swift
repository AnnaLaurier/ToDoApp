//
//  ToDoDetailsPresenter.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

protocol IToDoDetailsPresenterInput: AnyObject {

    func viewIsReady()
}

class ToDoDetailsPresenter {

    weak var view: IToDoDetailsViewControllerInput?

    private let interactor: IToDoDetailsInteractorInput
    private let router: IToDoDetailsRouterInput

    private var title: String?
    private var date = Date()
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
        title = "Заняться спортом"
        description = "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике."

        view?.updateTitle(title)
        view?.updateDate(dateFormatter.string(from: date))
        view?.updateDescription(description)
    }
}

private extension ToDoDetailsPresenter {
}
