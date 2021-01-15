//
//  NibView.swift
//  DevComponents
//
//  Created by abuzeid on 05.01.21.
//

import Foundation
#if canImport(UIKit)

    @objc open class NibView: UIView {
        var view: UIView!

        @objc public init() {
            super.init(frame: .zero)
            xibSetup()
        }

        override public init(frame: CGRect) {
            super.init(frame: frame)
            xibSetup()
        }

        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            xibSetup()
        }
    }

    private extension NibView {
        func xibSetup() {
            backgroundColor = UIColor.clear
            view = loadNib()
            view.frame = bounds
            addSubview(view)

            translatesAutoresizingMaskIntoConstraints = false
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }

    extension UIView {
        func loadNib() -> UIView {
            let bundle = Bundle(for: type(of: self))
            if let nibName = type(of: self).description().components(separatedBy: ".").last {
                let nib = UINib(nibName: nibName, bundle: bundle)
                return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
            }

            return UIView()
        }
    }
#endif
