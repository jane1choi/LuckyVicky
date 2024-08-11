//
//  UserDefaults+.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/11/24.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String {
        case isFirstLaunch
    }
    
    @UserDefault<Bool>(key: UserDefaults.Keys.isFirstLaunch.rawValue, defaultValue: true)
    static var isFirstLaunch
}
