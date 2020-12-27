//
//  XCConfigExtension.swift
//  DevExtensions
//
//  Created by abuzeid on 26.12.20.
//

import Foundation
public enum Config {
    public static func value<T>(for key: String) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            fatalError("Missing key")
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            fatalError("Missing key")
        }
    }
}
