//
//  SwipeTodismiss.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 29.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)
    public extension UIViewController {
        private var minimumVelocityToHide: CGFloat { 1500 }
        private var minimumScreenRatioToHide: CGFloat { 0.5 }
        private var animationDuration: TimeInterval { 0.2 }

        func enableSwipeToHide() {
            view.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
            view.addGestureRecognizer(panGesture)
        }

        @objc private func onPan(_ panGesture: UIPanGestureRecognizer) {
            func slideViewVerticallyTo(_ y: CGFloat) {
                view.frame.origin = CGPoint(x: 0, y: y)
            }

            switch panGesture.state {
            case .began, .changed:
                // If pan started or is ongoing then
                // slide the view to follow the finger
                let translation = panGesture.translation(in: view)
                let y = max(0, translation.y)
                slideViewVerticallyTo(y)

            case .ended:
                // If pan ended, decide it we should close or reset the view
                // based on the final position and the speed of the gesture
                let translation = panGesture.translation(in: view)
                let velocity = panGesture.velocity(in: view)
                let closing = (translation.y > view.frame.size.height * minimumScreenRatioToHide) ||
                    (velocity.y > minimumVelocityToHide)

                if closing {
                    UIView.animate(withDuration: animationDuration, animations: {
                        slideViewVerticallyTo(self.view.frame.size.height)
                    }, completion: { isCompleted in
                        if isCompleted {
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                } else {
                    // If not closing, reset the view to the top
                    UIView.animate(withDuration: animationDuration, animations: {
                        slideViewVerticallyTo(0)
                    })
                }

            default:
                // If gesture state is undefined, reset the view to the top
                UIView.animate(withDuration: animationDuration, animations: {
                    slideViewVerticallyTo(0)
                })
            }
        }
    }
#endif
