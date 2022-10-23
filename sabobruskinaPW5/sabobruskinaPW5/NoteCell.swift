//
//  NoteCell.swift
//  sabobruskinaPW5
//
//  Created by Станислава on 21.10.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    var textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.setHeight(to: 140)
        
        contentView.addSubview(textView)
        textView.pin(to: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(note: ShortNote){
        textView.text = note.text
        textView.isEditable = false
        textView.textColor = .systemGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
