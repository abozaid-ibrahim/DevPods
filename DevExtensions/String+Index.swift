//
//  String+Index.swift
//  DevExtensions
//
//  Created by abuzeid on 14.01.21.
//

import Foundation
public extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
