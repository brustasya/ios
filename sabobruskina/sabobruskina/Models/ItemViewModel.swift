//
//  ItemViewModel.swift
//  sabobruskina
//
//  Created by Станислава on 15.12.2022.
//

import UIKit
final class ItemViewModel {
    public var title: String
    public var controller: UIViewController?
    
    init(title: String, controller: UIViewController?) {
        self.title = title
        self.controller =  controller
    }
}
