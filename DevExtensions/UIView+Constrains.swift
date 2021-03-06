//
//  UIView+Constrains.swift
//  DevExtensions
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)
    public extension UIView {
        func setConstrainsEqualToParentEdges(top: Float = 0,
                                             bottom: Float = 0,
                                             leading: Float = 0,
                                             trailing: Float = 0) {
            guard let parent = superview else {
                fatalError("This view doesn't have a parent")
            }

            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: CGFloat(leading)),
                trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -CGFloat(trailing)),
                topAnchor.constraint(equalTo: parent.topAnchor, constant: CGFloat(top)),
                bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -CGFloat(bottom))])
        }

        @available(iOS 11.0, *)
        func setConstrainsEqualToSafeArea(top: Float = 0,
                                          bottom: Float = 0,
                                          leading: Float = 0,
                                          trailing: Float = 0) {
            guard let parent = superview?.safeAreaLayoutGuide else {
                fatalError("This view doesn't have a parent or safe area")
            }
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: CGFloat(leading)),
                trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -CGFloat(trailing)),
                topAnchor.constraint(equalTo: parent.topAnchor, constant: CGFloat(top)),
                bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -CGFloat(bottom))])
        }

        func setViewAtBottom(of view: UIView, with margin: CGFloat = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margin)])
        }
    }
#endif
