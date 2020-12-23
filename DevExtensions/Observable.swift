//
//  Observable.swift
//  DevExtensions
//
//  Created by abuzeid on 21.12.20.
//

import Foundation

public final class Observable<T> {
    private var observers = [UUID: (T) -> Void]()
    private var queues = [UUID: DispatchQueue]()

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
    public func subscribe(on queue: DispatchQueue = .main, _ observer: @escaping ((T) -> Void)) -> UUID {
        let id = UUID()
        observers[id] = observer
        queues[id] = queue
        observer(value)
        return id
    }

    public func unsubscribe(id: UUID) {
        observers.removeValue(forKey: id)
        queues.removeValue(forKey: id)
    }

    public func accept(_ newValue: T) {
        self.newValue = newValue
    }
}
