//
//  Weak.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

struct Weak<T: AnyObject> {

    private(set) weak var object: T?

    init(_ object: T) {
        self.object = object
    }

    func map<U>(_ transform: (T) -> U) -> Weak<U>? {
        switch object {
        case .some(let object):
            return Weak<U>(transform(object))
        case .none:
            return .none
        }
    }
}
