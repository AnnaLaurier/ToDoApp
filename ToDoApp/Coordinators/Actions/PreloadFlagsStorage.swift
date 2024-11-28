//
//  PreloadFlagsStorage.swift
//  ToDoApp
//
//  Created by Anna Lavrova on 25.11.2024.
//

import Foundation

extension PreloadAction {

    final class PreloadFlagsStorage {

        enum Flag: String {
            case toDoAPILoaded
        }

        func getFlag(_ key: Flag) -> Bool {
            return UserDefaults.standard.bool(forKey: key.rawValue)
        }

        func setFlag(_ key: Flag, newValue: Bool) {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}
