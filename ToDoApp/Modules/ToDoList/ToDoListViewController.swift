//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Anna Lavrova on 20.11.2024.
//

import UIKit

protocol IToDoListViewControllerInput: AnyObject {

    func reloadData(viewModels: [ToDoTableViewCell.ViewModel])
}

class ToDoListViewController: UIViewController {

    private let presenter: IToDoListPresenterInput

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseID)
        tableView.estimatedRowHeight = 44.0
        tableView.contentInset.bottom = 80
        tableView.backgroundColor = .clear

        return tableView
    }()

    private lazy var bottomListCountView: BottomListCountView = {
        let view = BottomListCountView()

        return view
    }()

    private var viewModels: [ToDoTableViewCell.ViewModel] = []

    init(presenter: IToDoListPresenterInput) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureAppearance()
    }
}

extension ToDoListViewController: IToDoListViewControllerInput {

    func reloadData(viewModels: [ToDoTableViewCell.ViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()

        bottomListCountView.configure("\(viewModels.count) Задач")
    }
}

extension ToDoListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ToDoTableViewCell.reuseID,
            for: indexPath
        )

        if let todoCell = cell as? ToDoTableViewCell {
            let viewModel = viewModels[indexPath.row]
            todoCell.configure(viewModel)
        }

        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        let toDoModel = viewModels[indexPath.row]

        let editAction = UIAction(
            title: "Редактировать",
            image: UIImage(systemName: "square.and.pencil")
        ) { [weak self] action in
            self?.presenter.editToDoTappedHandler(toDoModel.id)
        }

        let shareAction = UIAction(
            title: "Поделиться",
            image: UIImage(systemName: "square.and.arrow.up")
        ) { [weak self] action in
            self?.presenter.shareToDoTappedHandler(toDoModel.id)
        }

        let deleteAction = UIAction(
            title: "Удалить",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] action in
            self?.presenter.deleteToDoTappedHandler(toDoModel.id)
        }

        let menu = UIMenu(
            title: "",
            children: [editAction, shareAction, deleteAction]
        )

        let previewViewController = ToDoCellPreviewViewController(
            model: ToDoCellPreviewViewController.Model(
                title: toDoModel.title,
                description: toDoModel.description,
                date: toDoModel.date
            ),
            customHeight: cell.frame.height
        )

        previewViewController.view.frame = cell.frame
//        previewViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        previewViewController.view.heightAnchor.constraint(
//            equalToConstant: cell.frame.height
//        ).isActive = true

        let contextMenuConfiguration = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: {
                return previewViewController
            },
            actionProvider: { _ in
                return menu
            }
        )

        return contextMenuConfiguration
    }
}

private extension ToDoListViewController {

    func setConstrains() {
        view.addSubview(tableView)
        view.addSubview(bottomListCountView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomListCountView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            bottomListCountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomListCountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomListCountView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureAppearance() {
        title = "Задачи"
        view.backgroundColor = .black

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationBarAppearance.backgroundColor = UIColor.black
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .compact)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .compactPrompt)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .defaultPrompt)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance

        navigationController?.navigationBar.tintColor = .orange
    }
}
