//
//  UIView+Layer.swift
//  UPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)

    public extension UIView {
        @IBInspectable var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.masksToBounds = true
                layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
            }
        }

        @IBInspectable var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }

        @IBInspectable var borderColor: UIColor? {
            get {
                guard let color = layer.borderColor else { return nil }
                return UIColor(cgColor: color)
            }
            set {
                layer.borderColor = newValue?.cgColor
            }
        }
    }
#endif
