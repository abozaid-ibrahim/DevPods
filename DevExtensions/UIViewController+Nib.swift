//
//  UIViewController+Nib.swift
//  DevExtensions
//
//  Created by abuzeid on 14.01.21.
//

import Foundation
#if canImport(UIKit)

    public extension UIViewController {
        static var nibName: String {
            return String(describing: self)
        }
    }
#endif
