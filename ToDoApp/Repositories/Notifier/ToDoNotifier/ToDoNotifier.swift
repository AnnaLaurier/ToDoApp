//
//  ToDoNotifier.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

final class ToDoNotifier {

    private let subscriber: Subscriber<AnyObject> = .init()
}

extension ToDoNotifier: IToDoNotifier {

    func subscribe(_ listener: IToDoListener) {
        subscriber.subscribe(listener)
    }

    func unsubscribe(_ listener: IToDoListener) {
        subscriber.unsubscribe(listener)
    }

    func notify(_ listener: @escaping (IToDoListener?) -> Void) {
        subscriber.notifyAll {
            listener($0 as? IToDoListener)
        }
    }
}
