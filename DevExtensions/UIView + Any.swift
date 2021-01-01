//
//  UIView + Any.swift
//  Direct
//
//  Created by abuzeid on 6/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerNib(_ id: String) {
        register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}

extension UIView {
    // OUTPUT 1

    func dropShadow() {
//        let shadowSize: CGFloat = 15
//        let contactRect = CGRect(x: -shadowSize, y: bounds.height - (shadowSize * 0.2), width: bounds.width + shadowSize * 2, height: shadowSize)
//        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
//        self.layer.shadowRadius = self.layer.cornerRadius
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.6

        //
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
    }

    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
