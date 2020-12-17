//
//  APIClient.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//
import Foundation

final class Page {
    var currentPage = 1
    let maxPages = 22
    var countPerPage = 20
    var shouldLoadMore: Bool {
        currentPage <= maxPages
    }

    func newPageFetched() {
        currentPage += 1
    }
}
