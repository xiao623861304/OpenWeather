//
//  Observable.swift
//  OpenWeather
//
//  Created by yan feng on 2023/5/12.
//

import Foundation

struct Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    mutating func bind(listener: Listener?) {
        self.listener = listener
    }
    mutating func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
