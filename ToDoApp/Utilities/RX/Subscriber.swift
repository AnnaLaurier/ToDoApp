//
//  Subscriber.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

final class Subscriber<T: AnyObject> {

    private let queue = DispatchQueue(
        label: "com.subscriber.queue",
        attributes: .concurrent
    )

    private var subscribers: [Weak<T>] = []
}

extension Subscriber {

    func subscribe(_ subscriber: T) {
        queue.async(flags: .barrier) { [weak self] in
            self?.removeSubscriber(subscriber)
            self?.subscribers.append(Weak(subscriber))

            self?.flush()
        }
    }

    func unsubscribe(_ subscriber: T) {
        queue.async(flags: .barrier) { [weak self] in
            self?.removeSubscriber(subscriber)
        }
    }

    func notifyAll(completion: @escaping (T) -> Void) {
        queue.async { [weak self] in
            guard let self else { return }

            for subscriber in self.subscribers {
                guard let object = subscriber.object else { return }

                DispatchQueue.main.async {
                    completion(object)
                }
            }
        }
    }
}

private extension Subscriber {

    func flush() {
        subscribers.removeAll { $0.object == nil }
    }

    func removeSubscriber(_ subscriber: T) {
        subscribers.removeAll { $0.object === subscriber }
    }
}
