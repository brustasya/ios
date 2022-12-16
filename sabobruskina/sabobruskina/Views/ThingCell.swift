//
//  ThingCell.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit

final class ThingCell: UITableViewCell {
    static let reuseIdentifier = "ThingCell"
    private var button = UIButton()
    private let thingTitleLabel = UITextView()
    private var edit = UIButton()
    private var controller: UIViewController?
    
    private let background = UIColor(rgb: "#fff9ea")
    
    var isEditable = 0
    var isSaved = 0
    var isSelect = 0
    
    var key = ""
    let def = UserDefaults.standard
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        key = randomString(length: 10)
        
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.backgroundColor = background
        
        setupImageView()
        setupTitleLabel()
        setupEditButton()
    }
    
    private func setupEditButton() {
        edit.layer.cornerCurve = .continuous
        edit.clipsToBounds = true
        edit.contentMode = .scaleAspectFill
        
        contentView.addSubview(edit)
        
        edit.setImage(UIImage(named:"done.png"), for: UIControl.State.normal)
        
        edit.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 15
        ).isActive = true
        
        edit.rightAnchor.constraint(
            equalTo: contentView.rightAnchor,
            constant: -20
        ).isActive = true
        
        edit.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -15
        ).isActive = true
        
        edit.pinWidth(to: edit.heightAnchor)
        edit.addTarget(self, action: #selector(editText), for: .touchUpInside)
    }
    
    private func setupImageView() {
        button.layer.cornerCurve = .continuous
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        
        contentView.addSubview(button)
        
        button.setImage(UIImage(named:"circled.png"), for: UIControl.State.normal)
        
        
        button.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 15
        ).isActive = true
        
        button.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: 16
        ).isActive = true
        
        button.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -15
        ).isActive = true
        
        button.pinWidth(to: button.heightAnchor)
        button.addTarget(self, action: #selector(selectThing), for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        thingTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        thingTitleLabel.textColor = .label
        thingTitleLabel.setHeight(to: 28)
        thingTitleLabel.backgroundColor = background
        
        contentView.addSubview(thingTitleLabel)
        
        thingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        thingTitleLabel.leadingAnchor.constraint(
            equalTo: button.trailingAnchor,
            constant: 10
        ).isActive = true
        
        thingTitleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 8
        ).isActive = true
        
        thingTitleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: - Public Methods
    public func configure(with thingModel: ItemViewModel){
        thingTitleLabel.text = thingModel.title
        
        if (isSaved != 0) {
            thingTitleLabel.text = def.string(forKey: key)
        }
        isSaved = 1
    }
    
    public func getTitle() -> String {
        return thingTitleLabel.text
    }
    
    // MARK: - Objc functions
    @objc
    func editText(_ sender: UIButton) {
        if (isEditable == 0) {
            def.set(thingTitleLabel.text, forKey: key)
            self.thingTitleLabel.isEditable = false
            edit.setImage(UIImage(named:"edit.png"), for: UIControl.State.normal)
            controller?.viewDidLoad()
            isEditable = 1
        } else {
            self.thingTitleLabel.isEditable = true
            edit.setImage(UIImage(named:"done.png"), for: UIControl.State.normal)
            isEditable = 0
        }
    }
    
    @objc
    func selectThing(_ sender: UIButton) {
        if (isSelect == 0) {
            button.setImage(UIImage(named: "ok.png"), for: UIControl.State.normal)
            isSelect = 1
        } else {
            button.setImage(UIImage(named: "circled.png"), for: UIControl.State.normal)
            isSelect = 0
        }
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

