//
//  UserEntity.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation

struct UserEntity: Identifiable {
    var id: String
    var name: String
    var usedCount: Int
    var lastUsedDate: String
}

extension UserEntity {
    func toDTO() -> UserDTO {
        .init(id: id,
              name: name,
              usedCount: usedCount,
              lastUsedDate: lastUsedDate)
    }
}
