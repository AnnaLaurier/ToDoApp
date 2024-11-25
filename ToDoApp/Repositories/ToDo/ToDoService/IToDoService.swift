//
//  IToDoService.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

protocol IToDoService {

    func getToDoList(
        completionQueue: DispatchQueue,
        completion: @escaping (Result<[ToDos], Error>) -> Void
    )
}
