//
//  UIColor+DarkMode.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 28.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    static var whiteColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
            }
        } else {
            return UIColor.white
        }
    }

    static var blackColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
        } else {
            return UIColor.black
        }
    }
}
