//
//  UICollectionView+Cell.swift
//  DevExtensions
//
//  Created by abuzeid on 10.01.21.
//

import Foundation

import Foundation
#if canImport(UIKit)

    public extension UICollectionViewCell {
        static var identifier: String {
            return String(describing: self)
        }
    }

    public extension UICollectionView {
        func register<T: UICollectionViewCell>(_: T.Type) {
            let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }

        func dequeue<T: UICollectionViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
            let collectionView = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath)
            guard let cell = collectionView as? T else {
                fatalError("Failed to cast cell to \(T.identifier)")
            }
            return cell
        }
    }
#endif
