//
//  Pageable.swift
//  DevNetwork
//
//  Created by abuzeid on 23.12.20.
//

import Foundation

public protocol Pageable: class {
    var page: Page { get }
    func loadData(_ completion: ((Int) -> Void)?)
    func loadNewPage(for indexes: [Int])
}

public extension Pageable {
    func loadNewPage(for indexes: [Int]) {
        DispatchQueue.global(qos: .background)
            .async(group: .init(), qos: .background, flags: .barrier) { [weak self] in
                guard let self = self else { return }
                if self.page.fetching { return }
                guard let nextRow = indexes.max(),
                      self.page.shouldLoadMore(for: nextRow) else {
                    return
                }
                self.page.fetching = true
                self.loadData {
                    if $0 > 0 { self.page.newPageFetched() }
                    self.page.fetching = false
                }
            }
    }
}
