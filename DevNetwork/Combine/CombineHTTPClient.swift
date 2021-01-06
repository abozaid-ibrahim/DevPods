//
//  HTTPClient.swift
//  DevNetwork
//
//  Created by abuzeid on 21.12.20.
//

import Combine
import Foundation

@available(iOS 13.0, *)
public protocol APIClient {
    var jsonDecoder: JSONDecoder { get }
    func get<T: Decodable>(request: RequestBuilder) -> AnyPublisher<T, Error>
}

@available(iOS 13.0, *)
public final class CombineClient: APIClient {
    public let jsonDecoder: JSONDecoder = {
        let json = JSONDecoder()
        json.keyDecodingStrategy = .convertFromSnakeCase
        return json
    }()

    public init() {}

    public func get<T: Decodable>(request: RequestBuilder) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request.request!)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
