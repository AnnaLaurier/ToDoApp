//
//  DispatchQueueLabel.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

final class DispatchQueueLabel {

    static func create(system: String, subsystem: String? = nil) -> String {
        let components: [String?] = ["com", system, subsystem]

        return components
            .compactMap { $0 }
            .joined(separator: ".")
    }
}
