//
//  APIClient.swift
//  DevNetwork
//
//  Created by abuzeid on 19.12.20.
//

import Foundation

public protocol ApiClient {
    var jsonDecoder: JSONDecoder { get }
    func getData<T: Codable>(of request: RequestBuilder,
                             completion: @escaping (Result<T, NetworkError>) -> Void)
}

public final class HTTPClient: ApiClient {
    public let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.defaultJsonFormatter)
        return decoder
    }()

    public init() {}
    public func getData<T: Codable>(of request: RequestBuilder, completion: @escaping (Result<T, NetworkError>) -> Void) {
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
                let object = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                log(error)
                log(String(data: data, encoding: .utf8))
                completion(.failure(.failedToParseData))
            }
        }

        task.resume()
    }
}

func log(_ value: Any?...) {
    #if DEBUG
        print("Network>> \(value)")
    #endif
}

public extension DateFormatter {
    static var defaultJsonFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
}

public extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
