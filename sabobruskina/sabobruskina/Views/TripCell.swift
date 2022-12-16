//
//  TripCell.swift
//  sabobruskina
//
//  Created by Станислава on 09.12.2022.
//

import UIKit
final class TripCell: UITableViewCell {
    static let reuseIdentifier = "TripCell"
    
    private let background = UIColor(rgb: "#fff9ea")
    private let buttonBackground = UIColor(rgb: "#efe9e5")
    
    private var button = UIButton()
    private let tripTitleLabel = UITextView()
    private let tripDescriptionLabel = UITextView()
    private var controller: UIViewController?
    private var edit = UIButton()
    
    var imagePicker: ImagePicker!
    
    var isEditable = 0
    var isSaved = 0
    var titleKey = ""
    var descriptionKey = ""
    let def1 = UserDefaults.standard
    let def2 = UserDefaults.standard
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        titleKey = randomString(length: 10)
        descriptionKey = randomString(length: 11)
        setupView()
    }
    
    // MARK: - Private Methods
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func setupView() {
        self.backgroundColor = background

        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
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
            constant: 50
        ).isActive = true
        
        edit.rightAnchor.constraint(
            equalTo: contentView.rightAnchor,
            constant: -20
        ).isActive = true
        
        edit.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -50
        ).isActive = true
        
        edit.pinWidth(to: edit.heightAnchor)
        edit.addTarget(self, action: #selector(editText), for: .touchUpInside)
    }
    
    private func setupImageView() {
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.backgroundColor = buttonBackground
        
        contentView.addSubview(button)
        
        
        button.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 12
        ).isActive = true
        
        button.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: 16
        ).isActive = true
        
        button.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -12
        ).isActive = true
        
        button.pinWidth(to: button.heightAnchor)
        button.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        tripTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        tripTitleLabel.textColor = .label
        tripTitleLabel.setHeight(to: 28)
        tripTitleLabel.backgroundColor = background
        
        contentView.addSubview(tripTitleLabel)
        
        tripTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        tripTitleLabel.leadingAnchor.constraint(
            equalTo: button.trailingAnchor,
            constant: 12
        ).isActive = true
        
        tripTitleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 12
        ).isActive = true
        
        tripTitleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -12
        ).isActive = true
    }
    
    private func setupDescriptionLabel() {
        tripDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        tripDescriptionLabel.textColor = .secondaryLabel
        tripDescriptionLabel.setHeight(to: 70)
        tripDescriptionLabel.backgroundColor = background
        
        contentView.addSubview(tripDescriptionLabel)
        
        tripDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tripDescriptionLabel.leadingAnchor.constraint(
            equalTo: button.trailingAnchor,
            constant: 12
        ).isActive = true
        
        tripDescriptionLabel.topAnchor.constraint(
            equalTo: tripTitleLabel.bottomAnchor,
            constant: 0
        ).isActive = true
        
        tripDescriptionLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -12
        ).isActive = true
        
        tripDescriptionLabel.bottomAnchor.constraint(
            lessThanOrEqualTo: contentView.bottomAnchor,
            constant: -12
        ).isActive = true
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: TripViewModel) {
        self.imagePicker = ImagePicker(presentationController: controller!, delegate: self)
        tripTitleLabel.text = viewModel.title
        tripDescriptionLabel.text = viewModel.description
        
        if (isSaved != 0) {
            tripTitleLabel.text = def1.string(forKey: titleKey)
            tripDescriptionLabel.text = def2.string(forKey: descriptionKey)
        }
        isSaved = 1
    }
    
    public func getImage() -> UIImage {
        if button.backgroundImage(for: UIControl.State.normal) == nil {
            return UIImage(named: "image.jpeg")!
        } else {
            return button.backgroundImage(for: UIControl.State.normal)!
        }
    }
    
    public func getTitle() -> String {
        return tripTitleLabel.text
    }
    
    public func getDescription() -> String {
        return tripDescriptionLabel.text
    }
    
    public func setController(controller: UIViewController) {
        self.controller = controller;
    }
    
    // MARK: - Objc functions
    @objc
    func editText(_ sender: UIButton) {
        if (isEditable == 0) {
            def1.set(tripTitleLabel.text, forKey: titleKey)
            def2.set(tripDescriptionLabel.text, forKey: descriptionKey)
            
            self.tripTitleLabel.isEditable = false
            self.tripDescriptionLabel.isEditable = false
            edit.setImage(UIImage(named:"edit.png"), for: UIControl.State.normal)
            isEditable = 1
            controller?.viewDidLoad()
        } else {
            
            self.tripTitleLabel.isEditable = true
            self.tripDescriptionLabel.isEditable = true
            edit.setImage(UIImage(named:"done.png"), for: UIControl.State.normal)
            isEditable = 0
        }
    }
    
    @objc
    func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension TripCell: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.button.setBackgroundImage(image, for: UIControl.State.normal)
    }
}


