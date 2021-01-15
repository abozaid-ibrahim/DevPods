//
//  Observable.swift
//  DevExtensions
//
//  Created by abuzeid on 21.12.20.
//

import Foundation

public final class Observable<T>: DisposableTracker {
    private var observers = [Disposable: (T) -> Void]()
    private var queues = [Disposable: DispatchQueue]()
    private var newValue: T {
        didSet {
            observers.forEach { key, event in queues[key]?.async { event(self.newValue) }}
        }
    }

    public var value: T {
        return newValue
    }

    public init(_ value: T) {
        newValue = value
    }

    @discardableResult
    public func subscribe(on queue: DispatchQueue = .main, _ observer: @escaping ((T) -> Void)) -> Disposable {
        let id = KeysGenerator.shared.newKey
        observers[id] = observer
        queues[id] = queue
        observer(value)
        return id
    }

    public func unsubscribe(_ ids: Disposable...) {
        ids.forEach {
            observers.removeValue(forKey: $0)
            queues.removeValue(forKey: $0)
        }
    }

    public func accept(_ newValue: T) {
        self.newValue = newValue
    }

    func removeDisposedKeys() {
        observers.keys.forEach {
            if KeysGenerator.shared.observers[$0] == nil {
                unsubscribe($0)
            }
        }
    }
}
