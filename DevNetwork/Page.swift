//
//  APIClient.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//
import Foundation

public final class Page {
    public init() {}
    public var current = 0
    public var maxPages = 20
    public var size = 20
    public var fetched = 0
    public var fetching: Bool = false
    public func shouldLoadMore(for index: Int) -> Bool {
        return current <= maxPages && fetched <= (index + 1)
    }

    public var shouldLoadMore: Bool {
        size <= maxPages
    }

    public func newPageFetched() {
        current += 1
        fetched += size
    }
}
