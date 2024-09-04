//
//  AppScene.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/30/24.
//

import Foundation

enum AppScene: Hashable, Identifiable {
    case login
    case selectCharacter
    case inputTrouble
    case result(userInput: String, result: String)
    
    var id: Self {
        return self
    }
}
