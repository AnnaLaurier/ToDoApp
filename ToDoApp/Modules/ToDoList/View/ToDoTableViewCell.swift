//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Anna Lavrova on 21.11.2024.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    private var completedHandler: (() -> Void)?
    private var onTappedHandler: (() -> Void)?

    private let strokeAttributes: [NSAttributedString.Key: Any] = [
        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
        .strikethroughColor: UIColor.gray
    ]

    private let defaultAttributes: [NSAttributedString.Key: Any] = [
        .strikethroughColor: UIColor.clear
    ]

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 8
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 12,
            leading: 0,
            bottom: 12,
            trailing: 0
        )
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6

        return stackView
    }()

    private lazy var checkBoxView: CheckBoxView = {
        let view = CheckBoxView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2

        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
        configureAppearance()
        configureActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        checkBoxView.setCheckBox(false)

        titleLabel.text = nil
        descriptionLabel.text = nil
        dateLabel.text = nil

        completedHandler = nil
        onTappedHandler = nil
    }
}

extension ToDoTableViewCell {

    func configure(_ viewModel: ViewModel) {
        checkBoxView.setCheckBox(viewModel.completed)

        titleLabel.text = viewModel.title
        titleLabel.textColor = viewModel.completed ? .gray : .white
        titleLabel.attributedText = NSAttributedString(
            string: viewModel.title ,
            attributes: viewModel.completed ? strokeAttributes : defaultAttributes
        )

        descriptionLabel.text = viewModel.description
        descriptionLabel.textColor = viewModel.completed ? .gray : .white

        dateLabel.text = dateFormatter.string(from: viewModel.date)

        completedHandler = {
            viewModel.completedHandler?()
        }

        onTappedHandler = {
            viewModel.onTappedHandler?()
        }
    }
}

private extension ToDoTableViewCell {

    func setupSubviews() {
        contentView.addSubview(horizontalStackView)

        horizontalStackView.addArrangedSubview(checkBoxView)
        horizontalStackView.addArrangedSubview(verticalStackView)

        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(dateLabel)

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            checkBoxView.heightAnchor.constraint(equalToConstant: 24),
            checkBoxView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .black
    }

    func configureActions() {
        let checkboxTapGesture = UITapGestureRecognizer(target: self, action: #selector(onCheckboxTapped))
        horizontalStackView.addGestureRecognizer(checkboxTapGesture)

        let contentTapGesture = UITapGestureRecognizer(target: self, action: #selector(onContentTapped))
        verticalStackView.addGestureRecognizer(contentTapGesture)
    }

    @objc
    func onCheckboxTapped() {
        completedHandler?()
    }

    @objc
    func onContentTapped() {
        onTappedHandler?()
    }
}
