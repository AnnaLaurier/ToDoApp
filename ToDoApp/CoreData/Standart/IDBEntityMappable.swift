//
//  IDBEntityMappable.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 24.11.2024.
//

import Foundation

protocol IDBEntityMappable: AnyObject {

    associatedtype Model
    associatedtype EntityMO

    func convert(entity: EntityMO) -> Model?
    func bind(entity: EntityMO, model: Model)
}
