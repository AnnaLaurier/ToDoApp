//
//  UITableViewCell+.swift
//  ToDoList
//
//  Created by Anna Lavrova on 24.11.2024.
//

import UIKit

extension UITableViewCell {

    static var reuseID: String {
        String(describing: self)
    }
}
