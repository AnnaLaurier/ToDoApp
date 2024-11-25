//
//  TDTextView.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

final class TDTextView: UITextView {

    var placeholder: String? {
        didSet {
            updatePlaceholderText()
        }
    }

    var customTextContainerInset = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0
    ) {
        didSet {
            textContainerInset = customTextContainerInset
        }
    }

    var showsToolbar = false {
        didSet {
            inputAccessoryView = showsToolbar ? toolBar : nil
        }
    }

    var inputChangeHandler: ((String?) -> Void)?
    var backspaceEventHadler: (() -> Void)?
    var becomeResponderHandler: (() -> Void)?
    var resignResponderHandler: (() -> Void)?

    override var text: String? {
        didSet {
            updatePlaceholderText()
        }
    }

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44)
        )
        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(editingDidEnd)
        )
        doneButton.tintColor = .orange

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let buttons = [flexibleSpace, doneButton]
        toolBar.setItems(buttons, animated: true)

        return toolBar
    }()

    override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)

        placeSubviews()
        configureAppearance()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func deleteBackward() {
        backspaceEventHadler?()
        super.deleteBackward()
    }
}

private extension TDTextView {

    @objc
    func editingDidBegin() {
        becomeResponderHandler?()
    }

    @objc
    func editingDidEnd() {
        resignFirstResponder()
        resignResponderHandler?()
    }

    @objc
    func edited() {
        updatePlaceholderText()

        inputChangeHandler?(text)
    }

    func setupActions() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(edited),
            name: UITextView.textDidChangeNotification,
            object: self
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editingDidBegin),
            name: UITextView.textDidBeginEditingNotification,
            object: self
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editingDidEnd),
            name: UITextView.textDidEndEditingNotification,
            object: self
        )
    }
}

private extension TDTextView {

    func placeSubviews() {
        addSubview(placeholderLabel)

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            placeholderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configureAppearance() {
        backgroundColor = .clear
        textContainerInset = customTextContainerInset
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        adjustsFontForContentSizeCategory = true
    }

    func updatePlaceholderText() {
        placeholderLabel.text = placeholder
        placeholderLabel.isHidden = hasText
    }
}
