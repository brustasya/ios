//
//  ViewController.swift
//  sabobruskinaHW4
//
//  Created by Станислава on 13.10.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private var value: Int = 0
    private let incrementButton = UIButton()
    let colorPaletteView = ColorPaletteView()
    private let commentView = UIView()
    var buttonsSV = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        commentView.isHidden = true
        colorPaletteView.isHidden = true
        
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupColorControlSV()
        view.addSubview(setupCommentView())
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        
        colorsButton.addTarget(
            self,
            action: #selector(paletteButtonPressed),
            for: .touchUpInside
        )
        
        let notesButton = makeMenuButton(title: "📝")
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        
        let newsButton = makeMenuButton(title: "📰")
        
        buttonsSV = UIStackView(
            arrangedSubviews: [colorsButton, notesButton, newsButton]
        )
        
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        
        buttonsSV.pin(
            to: self.view,
            [.left: 24, .right: 24]
        )
        buttonsSV.pinBottom(
            to: self.view.safeAreaLayoutGuide.bottomAnchor, 24
        )
    }
    
    @objc
    private func notesButtonPressed(_ sender: UIButton) {
        let notesController = NotesViewController()
        notesController.modalPresentationStyle = .popover
        present(notesController, animated: true)
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        
        button.titleLabel?.font = .systemFont(
            ofSize: 16.0,
            weight: .medium
        )
        
        button.backgroundColor = .white
        
        button.heightAnchor.constraint(
            equalTo: button.widthAnchor
        ).isActive = true
        
        return button
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        
        colorPaletteView.translatesAutoresizingMaskIntoConstraints =
        false
        
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(
                equalTo: incrementButton.bottomAnchor,
                constant: 8
            ),
            colorPaletteView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            colorPaletteView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
            colorPaletteView.bottomAnchor.constraint(
                equalTo: buttonsSV.topAnchor,
                constant: -8
            )
        ])
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(
            ofSize: 16.0,
            weight: .medium
        )
        
        incrementButton.backgroundColor = .white
        
        incrementButton.layer.shadowColor = UIColor.black.cgColor
        incrementButton.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        incrementButton.layer.shadowOpacity = 0.1
        incrementButton.layer.shadowRadius = 5.0
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(
            to: self.view,
            [.left: 24, .right: 24]
        )
        
        incrementButton.addTarget(
            self, action: #selector(incrementButtonPressed),
            for: .touchUpInside
        )
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(
            ofSize: 40.0,
            weight: .bold
        )
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    
    @objc
    private func incrementButtonPressed() {
        commentView.isHidden = false
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        valueLabel.text = String(value)
        updateCommentLabel(value: value)
    }
    
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        
        commentLabel.font = .systemFont(
            ofSize: 14.0,
            weight: .regular
        )
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(
            to: commentView,
            [.top: 16, .left: 16, .bottom: 16, .right: 16]
        )
        
        return commentView
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐⭐⭐⭐⭐⭐⭐⭐⭐"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
}

