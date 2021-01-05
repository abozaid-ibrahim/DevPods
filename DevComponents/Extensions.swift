//
//  Extensions.swift
//
//  Created by abuzeid on 22.12.20.
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
    }
#endif
