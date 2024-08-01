//
//  GptCommonDTO.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

struct Message: Codable {
    let role: Role
    let content: String
}

enum GptModel: String, Codable {
    case main = "gpt-4o-mini"
}

enum Role: String, Codable {
    case system
    case user
    case assistant
}
