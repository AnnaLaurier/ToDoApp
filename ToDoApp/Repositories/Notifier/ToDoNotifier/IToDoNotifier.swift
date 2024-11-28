//
//  IToDoNotifier.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 28.11.2024.
//

import Foundation

protocol IToDoNotifier: AnyObject,
                        IToDoSubscribeNotifier {

    func notify(_ listener: @escaping (IToDoListener?) -> Void)
}

protocol IToDoSubscribeNotifier: AnyObject {

    func subscribe(_ listener: IToDoListener)

    func unsubscribe(_ listener: IToDoListener)
}
