//
//  Action.swift
//  DevExtensions
//
//  Created by abuzeid on 19.12.20.
//

import Foundation
public struct DataAction<T> {
    public let data: Observable<T>
    public let isLoading: Observable<Bool> = .init(false)
    public let error: Observable<String?> = .init(nil)
    public init(_ value: T) {
        data = .init(value)
    }
}
