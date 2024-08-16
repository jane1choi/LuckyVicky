//
//  UserDefaults+.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/11/24.
//

import Foundation

extension UserDefaults {
    
    typealias UserDefaultKeys = UserDefaults.Keys
    
    enum Keys: String {
        case isFirstLaunch
        case userId
        case selectedCharacterId
        case usedCount
    }
    
    @UserDefault<Bool>(key: UserDefaultKeys.isFirstLaunch.rawValue, defaultValue: true)
    static var isFirstLaunch
    
    @UserDefault<String>(key: UserDefaultKeys.userId.rawValue, defaultValue: "")
    static var userId
    
    @UserDefault<Int>(key: UserDefaultKeys.selectedCharacterId.rawValue, defaultValue: 0)
    static var selectedCharacterId
    
    @UserDefault<Int>(key:UserDefaultKeys.usedCount.rawValue, defaultValue: 0)
    static var usedCount
}
