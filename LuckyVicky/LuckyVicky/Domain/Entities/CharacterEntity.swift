//
//  CharacterEntity.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import Foundation

struct CharacterEntity: Hashable {
    let id: Int
    let name: String
    let introduction: String
    let imageName: LuckyVickyImage
    
    static let characters: [CharacterEntity] = [
        CharacterEntity(id: 0, name: "원영", introduction: "완전 럭키비키잖앙~", imageName: .wonyoung),
        CharacterEntity(id: 1, name: "희진", introduction: "맞다이로 들어와", imageName: .heejin),
        CharacterEntity(id: 2, name: "우희", introduction: "얼마나 잘 되려고 이럴까?", imageName: .woohee),
        CharacterEntity(id: 3, name: "흥민", introduction: "그냥 좋다고 생각하면 돼.", imageName: .heungmin)
    ]
}
