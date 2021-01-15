//
//  RatingBar.swift
//  DevComponents
//
//  Created by abuzeid on 05.01.21.
//

import Foundation
#if canImport(UIKit)

    protocol RatingBarType {
        var rating: CGFloat { get }
        var ratingMax: CGFloat { get }
        var isIndicator: Bool { get }
        var animationTimeInterval: TimeInterval { get }
    }

    final class RatingBar: UIView, RatingBarType {
        @IBInspectable var ratingMax: CGFloat = 5
        @IBInspectable var canAnimation: Bool = false
        @IBInspectable var animationTimeInterval: TimeInterval = 0.2
        @IBInspectable var isIndicator: Bool = false
        @IBInspectable var imageLight: UIImage = UIImage(named: "star_on")!
        @IBInspectable var imageDark: UIImage = UIImage(named: "star_off")!
        @IBInspectable var rating: CGFloat = 0 {
            didSet {
                if 0 >= rating { rating = 0 }
                else if ratingMax <= rating { rating = ratingMax }
                setNeedsLayout()
            }
        }

        private var foregroundRatingView: UIView!
        private var backgroundRatingView: UIView!
        private var numStars: Int { Int(ratingMax) }

        override init(frame: CGRect) {
            super.init(frame: frame)
            buildView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            buildView()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            animateChange()
        }
    }

    // MARK: setup

    private extension RatingBar {
        func buildView() {
            subviews.forEach { $0.removeFromSuperview() }
            backgroundRatingView = createRatingView(image: imageDark)
            foregroundRatingView = createRatingView(image: imageLight)
            animationRatingChange()
            addSubview(backgroundRatingView)
            addSubview(foregroundRatingView)
            backgroundRatingView.setConstrainsEqualToParentEdges()
            foregroundRatingView.setConstrainsEqualToParentEdges()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRateView(sender:)))
            tapGesture.numberOfTapsRequired = 1
            addGestureRecognizer(tapGesture)
        }

        @objc func tapRateView(sender: UITapGestureRecognizer) {
            if isIndicator { return }
            let tapPoint = sender.location(in: self)
            let realRatingScore = tapPoint.x / (bounds.size.width / ratingMax)
            rating = round(realRatingScore)
        }

        func animateChange() {
            let animationTimeInterval = canAnimation ? self.animationTimeInterval : 0
            UIView.animate(withDuration: animationTimeInterval, animations: { self.animationRatingChange() })
        }

        func animationRatingChange() {
            let realRatingScore = rating / ratingMax
            foregroundRatingView.frame = CGRect(x: 0, y: 0, width: bounds.size.width * realRatingScore, height: bounds.size.height)
        }

        func createRatingView(image: UIImage) -> UIView {
            let view = UIView(frame: bounds)
            view.clipsToBounds = true
            view.backgroundColor = UIColor.clear
            let container = starsContainerView
            view.addSubview(container)
            container.setConstrainsEqualToParentEdges()
            for _ in 0 ..< numStars {
                let imageView = UIImageView(image: image)
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                container.addArrangedSubview(imageView)
            }
            return view
        }

        var starsContainerView: UIStackView {
            let container = UIStackView()
            container.alignment = .fill
            container.axis = .horizontal
            container.contentMode = .scaleToFill
            container.semanticContentAttribute = .unspecified
            container.distribution = .fillEqually
            container.spacing = 4
            return container
        }
    }
#endif
