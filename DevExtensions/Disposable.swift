//
//  File.swift
//
//
//  Created by abuzeid on 15.01.21.
//

import Foundation
public struct Disposable: Hashable {
    let id = UUID()
}

public extension Disposable {
    func disposed(by bag: DisposablesBag) {
        bag.insert(self)
    }
}

public class DisposablesBag {
    private var disposables: Set<Disposable> = .init()
    private weak var updater: DisposableTracker?
    public init() {}
    private func removeObservers() {
        disposables.forEach {
            KeysGenerator.shared.remove($0)
        }
        updater?.removeDisposedKeys()
    }

    func insert(_ disposable: Disposable) {
        disposables.insert(disposable)
    }

    deinit {
        removeObservers()
    }
}

protocol DisposableTracker: class {
    func removeDisposedKeys()
}

final class KeysGenerator {
    static let shared = KeysGenerator()
    var observers = [Disposable: Bool]()
    var newKey: Disposable {
        let key = Disposable()
        observers[key] = true
        return key
    }

    func remove(_ key: Disposable) {
        observers[key] = nil
    }
}
