//
//  APIClient.swift
//  MimiMusicPlayer
//
//  Created by abuzeid on 24.11.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiClient {
    func getData(of request: RequestBuilder?) -> Observable<Data>
}

final class HTTPClient: ApiClient {
    private let disposeBag = DisposeBag()
    func getData(of request: RequestBuilder?) -> Observable<Data> {
        return Observable.create { observer in
            guard let request = request?.request else {
                observer.onError(NetworkError.badRequest)
                return Disposables.create()
            }
            return URLSession.shared.rx.response(request: request)
                .subscribe(onNext: { response in
                               observer.onNext(response.data)
                               observer.onCompleted()
                           },
                           onError: { error in
                               observer.onError(error)
                           })
        }
    }
}
