//
//  AVPlayer+Rx.swift
//  UPlayer
//
//  Created by abuzeid on 01.12.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import AVFoundation
import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: AVPlayer {
    public var error: Observable<Error?> {
        return observe(Error.self, #keyPath(AVPlayer.error))
    }

   public func periodicTimeObserver(interval: CMTime) -> Observable<CMTime> {
        return Observable.create { observer in
            let timeObserver = self.base.addPeriodicTimeObserver(forInterval: interval, queue: nil) { time in
                observer.onNext(time)
            }
            return Disposables.create { self.base.removeTimeObserver(timeObserver) }
        }
    }
}
