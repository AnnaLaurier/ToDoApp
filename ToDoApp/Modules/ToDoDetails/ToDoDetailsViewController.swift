//
//  ToDoDetailsViewController.swift
//  ToDoList
//
//  Created by Anna Lavrova on 22.11.2024.
//

import UIKit

protocol IToDoDetailsViewControllerInput: AnyObject {

    func updateTitle(_ title: String?)
    func updateDate(_ dateString: String)
    func updateDescription(_ description: String?)
}

final class ToDoDetailsViewController: UIViewController {

    private let presenter: IToDoDetailsPresenterInput

    private lazy var formView: TDFormView = {
        let formView = TDFormView()
        formView.spacing = 6
        formView.insets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)

        return formView
    }()

    private lazy var titleTextView: TDTextView = {
        let textView = TDTextView()
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 34)
        textView.textContainer.lineFragmentPadding = 0
        textView.showsToolbar = true
        textView.placeholder = "Заголовок"
        textView.inputChangeHandler = { [weak self] title in
            self?.presenter.updateTitle(title)
        }

        return textView
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    private lazy var descriptionTextView: TDTextView = {
        let textView = TDTextView()
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainer.lineFragmentPadding = 0
        textView.showsToolbar = true
        textView.placeholder = "Описание"
        textView.inputChangeHandler = { [weak self] description in
            self?.presenter.updateDescription(description)
        }

        return textView
    }()

    init(presenter: IToDoDetailsPresenterInput) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

        setConstrains()
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        guard isMovingFromParent else { return }

        presenter.onReturnTapped()
    }
}

extension ToDoDetailsViewController: IToDoDetailsViewControllerInput {

    func updateTitle(_ title: String?) {
        titleTextView.text = title
    }

    func updateDate(_ dateString: String) {
        dateLabel.text = dateString
    }

    func updateDescription(_ description: String?) {
        descriptionTextView.text = description
    }
}

private extension ToDoDetailsViewController {

    func setConstrains() {
        view.addSubview(formView)

        formView.addArrangedSubview(titleTextView)
        formView.addArrangedSubview(dateLabel)
        formView.setCustomSpacing(16, after: dateLabel)
        formView.addArrangedSubview(descriptionTextView)

        formView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            formView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            formView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    func configureAppearance() {
        view.backgroundColor = .black
    }
}
