//
//  IToDoRepository.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

protocol IToDoRepository: AnyObject {

    func fetchToDoList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDoModel], Error>) -> Void
    )

    func fetchToDoDetails()
}
