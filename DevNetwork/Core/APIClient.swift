//
//  APIClient.swift
//  DevNetwork
//
//  Created by abuzeid on 19.12.20.
//

import Foundation

public protocol ApiClient {
    func getData<T: Decodable>(of request: RequestBuilder,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
    func parse<T: Decodable>(data: Data) throws -> T
}

open class HTTPClient: ApiClient {
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    public init() {}
    public func getData<T: Decodable>(of request: RequestBuilder, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = request.request else {
            completion(.failure(NetworkError.badRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            log(request)
            if let error = error {
                log(error)
                completion(.failure(.apiFailure))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ... 299).contains(httpResponse.statusCode) else {
                log("Response is not valid")
                completion(.failure(.apiFailure))
                return
            }
            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }
            do {
                completion(.success(try self.parse(data: data)))
            } catch {
                log(error)
                log(String(data: data, encoding: .utf8))
                completion(.failure(.failedToParseData))
            }
        }

        task.resume()
    }

    public func parse<T: Decodable>(data: Data) throws -> T {
        try jsonDecoder.decode(T.self, from: data)
    }
}

func log(_ value: Any?...) {
    #if DEBUG
        print("Network>> \(value)")
    #endif
}
