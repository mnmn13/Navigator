//
//  UserDefaultsExtensions.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

private enum Key {
    static let isLoggedIn = "isLoggedIn"
}

extension UserDefaults {
    var isLoggedIn: Bool {
        get {
            bool(forKey: Key.isLoggedIn)
        } set {
            setValue(newValue, forKey: Key.isLoggedIn)
        }
    }
}
