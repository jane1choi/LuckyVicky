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
        case selectedCharacterId
    }
    
    @UserDefault<Bool>(key: UserDefaults.Keys.isFirstLaunch.rawValue, defaultValue: true)
    static var isFirstLaunch
    
    @UserDefault<Int>(key: UserDefaults.Keys.selectedCharacterId.rawValue, defaultValue: 0)
    static var selectedCharacterId
}
