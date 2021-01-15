//
//  JsonDateFormatter.swift
//  DevNetwork
//
//  Created by abuzeid on 15.01.21.
//

import Foundation

public extension DateFormatter {
    static var defaultJsonFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
}
