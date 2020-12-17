//
//  TableView+Cell.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        let tableView = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        guard let cell = tableView as? T else {
            fatalError("Failed to cast cell to \(T.identifier)")
        }
        return cell
    }
}
