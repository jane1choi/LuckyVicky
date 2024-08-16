//
//  UserDTO.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation

struct UserDTO: Codable {
    var id: String
    var name: String
    var usedCount: Int
    var lastUsedDate: String
}

extension UserDTO {
    func toEntity() -> UserEntity {
        .init(id: id,
              name: name,
              usedCount: usedCount,
              lastUsedDate: lastUsedDate)
    }
}
