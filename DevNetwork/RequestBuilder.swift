//
//  APIClient.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    var path: String { get }

    var method: HttpMethod { get }

    var request: URLRequest? { get }

    var parameters: [String: Any] { get }
}

public enum HttpMethod: String {
    case get, post
}

extension RequestBuilder {
    var baseURL: String { "https://api-v2.hearthis.at/" }
    var request: URLRequest? {
        guard let url = URL(string: baseURL + path) else {
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
        return request
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
