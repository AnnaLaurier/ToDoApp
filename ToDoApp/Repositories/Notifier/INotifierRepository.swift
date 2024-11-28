//
//  INotifierRepository.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

protocol INotifierRepository: AnyObject {

    var toDoNotifier: IToDoNotifier { get }
}
