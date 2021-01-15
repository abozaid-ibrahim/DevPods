//
//  SnackBarPresenter.swift
//  DevComponents
//
//  Created by abuzeid on 22.12.20.
//
#if canImport(UIKit)
    public final class SnackBarPresenter {
        private static let slideDuration: TimeInterval = 0.3
        private static let holdDuration: TimeInterval = 4

        public static func present(snackbarView: SnackBarView, in parentView: UIView) {
            snackbarView.frame = CGRect(x: 10,
                                        y: parentView.bounds.height,
                                        width: parentView.bounds.width - 20,
                                        height: 0)
            snackbarView.translatesAutoresizingMaskIntoConstraints = false

            parentView.addSubview(snackbarView)
            parentView.bringSubviewToFront(snackbarView)

            let bottomAnchor = snackbarView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: 80)

            NSLayoutConstraint.activate([
                snackbarView.leadingAnchor.constraint(greaterThanOrEqualTo: parentView.leadingAnchor, constant: 20),
                snackbarView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
                bottomAnchor,
            ])

            snackbarView.layoutIfNeeded()
            let offset: CGFloat = 90
            snackbarView.alpha = 0

            UIView.animate(withDuration: slideDuration, delay: 0, options: .curveEaseIn, animations: {
                bottomAnchor.constant = -offset
                snackbarView.alpha = 1
                parentView.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: slideDuration, delay: holdDuration, options: .curveEaseInOut, animations: {
                    bottomAnchor.constant = offset
                    snackbarView.alpha = 0
                    parentView.layoutIfNeeded()
                }, completion: { _ in
                    snackbarView.removeFromSuperview()
                })
            }
        }

        public static func present(_ message: String, in parentView: UIView, above aboveView: UIView, margin: CGFloat = 4) {
            guard aboveView.isDescendant(of: parentView) else {
                return
            }

            let snackBarView = SnackBarView(viewModel: .init(text: message))
            snackBarView.translatesAutoresizingMaskIntoConstraints = false

            parentView.addSubview(snackBarView)
            parentView.bringSubviewToFront(snackBarView)

            let magnetConstraint = aboveView.topAnchor.constraint(equalTo: snackBarView.bottomAnchor, constant: margin)
            let bottomConstraint = snackBarView.topAnchor.constraint(equalTo: parentView.bottomAnchor)
            bottomConstraint.priority = .defaultHigh

            NSLayoutConstraint.activate([
                snackBarView.leadingAnchor.constraint(greaterThanOrEqualTo: parentView.leadingAnchor, constant: 20),
                snackBarView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
                bottomConstraint,
            ])

            parentView.layoutIfNeeded()
            snackBarView.alpha = 0

            UIView.animate(withDuration: slideDuration, delay: 0.2, options: .curveEaseIn, animations: {
                snackBarView.alpha = 1
                magnetConstraint.isActive = true
                parentView.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: slideDuration, delay: holdDuration, options: .curveEaseOut, animations: {
                    snackBarView.alpha = 0
                    magnetConstraint.isActive = false
                    parentView.layoutIfNeeded()
                }, completion: { _ in
                    snackBarView.removeFromSuperview()
                })
            }
        }
    }
#endif
