//
//  Logger.swift
//  DevExtensions
//
//  Created by abuzeid on 22.09.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

public enum LoggingLevels {
    var isEnabled: Bool { return true }
    case info, error
    var value: String {
        switch self {
        case .info:
            return ">INFO:"
        case .error:
            return ">>ERROR:"
        }
    }
}

public func log(_ value: Any?..., level: LoggingLevels = .info) {
    #if DEBUG
        if level.isEnabled { print("\(level.value) \(value)") }
    #endif
}
