//
//  TDFormView.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

final class TDFormView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.insetsLayoutMarginsFromSafeArea = false

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        placeSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TDFormView {

    var spacing: CGFloat {
        get { stackView.spacing }
        set { stackView.spacing = newValue }
    }

    var insets: UIEdgeInsets {
        get { stackView.layoutMargins }
        set { stackView.layoutMargins = newValue }
    }

    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    func setCustomSpacing(_ spacing: CGFloat, after view: UIView) {
        guard stackView.subviews.contains(where: { $0 === view }) else {
            return
        }

        stackView.setCustomSpacing(spacing, after: view)
    }
}

private extension TDFormView {

    func placeSubview() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
