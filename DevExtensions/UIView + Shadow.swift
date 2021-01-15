//
//  UIView + Any.swift
//  DevExtensions
//
//  Created by abuzeid on 6/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)

    extension UIView {
        func dropShadow() {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shadowRadius = 5
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .zero
            layer.shadowOpacity = 1
        }

        func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
            layer.masksToBounds = false
            layer.shadowColor = color.cgColor
            layer.shadowOpacity = opacity
            layer.shadowOffset = offSet
            layer.shadowRadius = radius

            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
#endif
