//
//  CheckBoxView.swift
//  ToDoList
//
//  Created by Anna Lavrova on 22.11.2024.
//

import UIKit

class CheckBoxView: UIView {

    private lazy var checkBoxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintAdjustmentMode = .normal

        return imageView
    }()

    private var isSelected = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        updateCheckBox(isSelected)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CheckBoxView {

    func setCheckBox(_ isSelected: Bool) {
        guard self.isSelected != isSelected else {
            return
        }

        self.isSelected = isSelected
        updateCheckBox(isSelected)
    }
}

private extension CheckBoxView {

    func setupSubviews() {
        addSubview(checkBoxImageView)

        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            checkBoxImageView.topAnchor.constraint(equalTo: topAnchor),
            checkBoxImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkBoxImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBoxImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func updateCheckBox(_ isSelected: Bool) {
        let image = UIImage(systemName: isSelected ? "checkmark.circle.fill" : "circle")
        checkBoxImageView.image = image
        checkBoxImageView.tintColor = .orange
    }
}

