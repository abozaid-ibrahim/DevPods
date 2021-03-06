//
//  APIClient.swift
//  DevNetwork
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    static var baseURL: String { get }

    var path: String { get }

    var method: HttpMethod { get }

    var request: URLRequest? { get }

    var parameters: [String: Any] { get }
}

public enum HttpMethod: String {
    case get, post
}

public extension RequestBuilder {
    var request: URLRequest? {
        guard let url = URL(string: Self.baseURL + path) else {
            return nil
        }
        var items = [URLQueryItem]()
        var urlComponents = URLComponents(string: url.absoluteString)
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents?.queryItems = items
        guard let queryUrl = urlComponents?.url else {
            return nil
        }
        var request = URLRequest(url: queryUrl,
                                 cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
                                 timeoutInterval: 30)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
