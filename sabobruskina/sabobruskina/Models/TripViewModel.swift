//
//  TripViewModel.swift
//  sabobruskina
//
//  Created by Станислава on 09.12.2022.
//

import UIKit
final class TripViewModel {
    public var title: String
    public var description: String
    public var image: UIImage
    public var controller: UIViewController?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        self.image = UIImage(named: "image.jpeg")!
        self.controller = ListViewController()
    }
}
