//
//  UIViewController+Error.swift
//  DevExtensions
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)

    public extension UIViewController {
        func show(error: String) {
            let alert = UIAlertController(title: nil, message: error, preferredStyle: .actionSheet)
            alert.enableSwipeToHide()
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
#endif
