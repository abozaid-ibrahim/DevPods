//
//  HttpClient+UTF8Decoder.swift
//  DevNetwork
//
//  Created by abuzeid on 15.01.21.
//

import Foundation
/// TrueCallerClient
open class TCClient: HTTPClient {
    override public func parse<T: Decodable>(data: Data) throws -> T {
        guard let string = String(data: data, encoding: .utf8),
            let codable = string as? T
        else {
            throw NetworkError.failedToParseData
        }
        return codable
    }
}
