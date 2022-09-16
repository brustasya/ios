//
//  ViewController.swift
//  sabobruskinaPW1
//
//  Created by Bobruskina Stanislava on 14.09.2022.
//

import UIKit
extension UIColor {
    
    static func subString(str: String, startIndex: Int, endIndex: Int) -> String {
        let start = str.index(str.startIndex, offsetBy: startIndex)
        let end = str.index(str.startIndex, offsetBy: endIndex)
        let range = start ..< end
        return String(str[range])
    }
    
    convenience init?(rgb: String) {
        let str = rgb.filter { $0 != "#" }
        if (str.count != 6) {
            return nil
        }
        
        let redHex = Self.subString(str: str, startIndex: 0, endIndex: 2)
        let greenHex = Self.subString(str: str, startIndex: 2, endIndex: 4)
        let blueHex = Self.subString(str: str, startIndex: 4, endIndex: 6)
        
        if let red = Int(redHex, radix: 16),
           let green = Int(greenHex, radix: 16),
           let blue = Int(blueHex, radix: 16) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: 1
            )
        } else {
            return nil
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        self.setColorAndCorner()
    }
    
    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        UIView.animate(withDuration: 2, animations: {
            self.setColorAndCorner()
        }) { completion in
            button?.isEnabled = true
        }
    }
    
    func setColorAndCorner() {
        var set = Set<UIColor>()
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        
        for view in self.views {
            view.layer.cornerRadius = .random(in: 0 ... view.bounds.height / 2)
            view.backgroundColor = UIColor(
                rgb: String(format:"%06X", Int.random(in: 0..<(1 << 24)))
                )
        }
    }
}
