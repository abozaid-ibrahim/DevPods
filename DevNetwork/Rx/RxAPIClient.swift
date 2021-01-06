//
//  APIClient.swift
//  UPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol ReactiveClient {
    var jsonDecoder: JSONDecoder { get }
    func getData<T: Decodable>(of request: RequestBuilder) -> Observable<T>
}

open class HTTPRxClient: ReactiveClient {
    public var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()

    public init() {}
    private let disposeBag = DisposeBag()

    public func getData<T>(of request: RequestBuilder) -> Observable<T> where T: Decodable {
        return Observable.create { observer in

            guard let request = request.request else {
                observer.onError(NetworkError.badRequest)
                return Disposables.create()
            }
            return URLSession.shared.rx.response(request: request)
                .subscribe(onNext: { response in
                               do {
                                   let model = try self.jsonDecoder.decode(T.self, from: response.data)
                                   observer.onNext(model)
                                   observer.onCompleted()
                               } catch {
                                   log(error)
                                   observer.onError(error)
                               }
                           },
                           onError: { error in
                               observer.onError(error)
                           })
        }
    }
}
