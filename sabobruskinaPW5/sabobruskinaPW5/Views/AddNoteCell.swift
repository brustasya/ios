//
//  AddNoteCell.swift
//  sabobruskinaPW5
//
//  Created by Станислава on 21.10.2022.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    var delegate: AddNoteDelegate?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        textView.delegate = self
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.text = "Type something"
        textView.setHeight(to: 140)
        
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped(_:)),
            for: .touchUpInside
        )
        
        addButton.alpha = 0.5
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(
            to: contentView,
            [.left: 16, .top: 16, .right: 16, .bottom: 16]
        )
        contentView.backgroundColor = .systemGray5
    }
    
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if (!textView.text.isEmpty && textView.text != "Type something"){
            delegate?.newNoteAdded(note: ShortNote(text: textView.text))
            textView.textColor = .lightGray
            textView.text = "Type something"
        }
    }
    
}

