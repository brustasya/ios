//
//  ColorPaletteView.swift
//  sabobruskinaPW5
//
//  Created by Станислава on 21.10.2022.
//

import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColor: UIColor = .systemGray6
    
    private var redComponent:CGFloat = 0
    private var greenComponent:CGFloat = 0
    private var blueComponent:CGFloat = 0
    private var alphaComponent:CGFloat = 1
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let redControl = ColorSliderView(
            colorName: "R",
            value: Float(redComponent)
        )
        let greenControl = ColorSliderView(
            colorName: "G",
            value: Float(greenComponent)
        )
        let blueControl = ColorSliderView(
            colorName: "B",
            value: Float(blueComponent)
        )
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
         
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
         
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                         for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self)
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            redComponent = CGFloat(slider.value)
        case 1:
            greenComponent = CGFloat(slider.value)
        default:
            blueComponent = CGFloat(slider.value)
        }
        
        self.chosenColor = UIColor (
            red: redComponent,
            green: greenComponent,
            blue: blueComponent,
            alpha: alphaComponent
        )
        
        UIView.animate(withDuration: 0.5) {
            self.superview?.backgroundColor = self.chosenColor
        }
        
        sendActions(for: .touchDragInside)
    }
}




