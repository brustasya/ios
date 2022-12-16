//
//  ItemCell.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit
final class ItemCell: UITableViewCell {
    static let reuseIdentifier = "ItemCell"
    private var button = UIButton()
    private let itemTitleLabel = UILabel()
    
    private let background = UIColor(rgb: "#fff9ea")
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.backgroundColor = background
        
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        button.layer.cornerCurve = .continuous
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        
        contentView.addSubview(button)
        
        button.setImage(UIImage(named:"circled.png"), for: UIControl.State.normal)
        
        
        button.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 18
        ).isActive = true
        
        button.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: 16
        ).isActive = true
        
        button.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -18
        ).isActive = true
        
        button.pinWidth(to: button.heightAnchor)
        button.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        itemTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        itemTitleLabel.textColor = .label
        itemTitleLabel.setHeight(to: 28)
        
        contentView.addSubview(itemTitleLabel)
        
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        itemTitleLabel.leadingAnchor.constraint(
            equalTo: button.trailingAnchor,
            constant: 10
        ).isActive = true
        
        itemTitleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 11
        ).isActive = true
        
        itemTitleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -10
        ).isActive = true
    }
    
    // MARK: - Public Methods
    public func configure(with thingModel: ItemViewModel){
        itemTitleLabel.text = thingModel.title
    }
    
    // MARK: - Objc functions
    @objc
    func showImagePicker(_ sender: UIButton) {
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
