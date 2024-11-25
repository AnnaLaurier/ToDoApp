//
//  ToDoCellPreviewViewController.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

final class ToDoCellPreviewViewController: UIViewController {

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter
    }()

    private lazy var formView: TDFormView = {
        let view = TDFormView()
        view.spacing = 6
        view.insets = UIEdgeInsets(
            top: 12,
            left: 16,
            bottom: 12,
            right: 16
        )

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .white

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray

        return label
    }()

    init(
        model: Model,
        customHeight: CGFloat
    ) {
        super.init(nibName: nil, bundle: nil)

        setConstrains(customHeight)
        configureAppearance()
        configure(model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ToDoCellPreviewViewController {

    func setConstrains(_ height: CGFloat) {
        view.addSubview(formView)

        formView.addArrangedSubview(titleLabel)
        formView.addArrangedSubview(descriptionLabel)
        formView.addArrangedSubview(dateLabel)

        formView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.topAnchor),
            formView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            formView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureAppearance() {
        view.backgroundColor = .darkGray
    }

    func configure(_ model: Model) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        dateLabel.text = dateFormatter.string(from: model.date)
    }
}
