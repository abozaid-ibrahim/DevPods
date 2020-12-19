//
//  UITableView+Header.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 28.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
#if canImport(UIKit)

public extension UITableView {
    func isLoading(_ loading: Bool) {
        (tableFooterView as? ActivityIndicatorView)?.set(isLoading: loading)
        sizeToFit(loading)
    }

    private func sizeToFit(_ loading: Bool) {
        guard let view = tableFooterView else { return }
        var frame = view.frame
        frame.size.height = loading ? 80 : 0
        view.frame = frame
        tableFooterView = view
    }

    func sizeHeaderToFit() {
        if let headerView = tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            tableHeaderView = headerView
        }
    }
}
#endif
