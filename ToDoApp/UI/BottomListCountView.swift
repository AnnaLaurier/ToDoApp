//
//  BottomListCountView.swift
//  ToDoList
//
//  Created by Anna Lavrova on 22.11.2024.
//

import UIKit

final class BottomListCountView: UIView {

    var onAddTappedHandler: (() -> Void)?

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 12,
            leading: 16,
            bottom: 12,
            trailing: 16
        )
        stack.isLayoutMarginsRelativeArrangement = true

        return stack
    }()

    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white

        return label
    }()

    private lazy var addImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "square.and.pencil")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintAdjustmentMode = .normal
        imageView.tintColor = .orange

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupConstrains()
        configureAppearance()
        configureAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomListCountView {

    func configure(_ title: String) {
        countLabel.text = title
    }
}

private extension BottomListCountView {

    func setupConstrains() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(emptyView)
        horizontalStack.addArrangedSubview(countLabel)
        horizontalStack.addArrangedSubview(addImageView)

        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            addImageView.heightAnchor.constraint(equalToConstant: 24),
            addImageView.widthAnchor.constraint(equalToConstant: 24),

            emptyView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configureAppearance() {
        backgroundColor = .black
    }

    func configureAction() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onAddImageViewTapped)
        )
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(tapGesture)
    }

    @objc
    func onAddImageViewTapped() {
        onAddTappedHandler?()
    }
}
