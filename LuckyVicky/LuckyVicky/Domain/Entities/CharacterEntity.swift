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
    let nickname: String
    let iconImage: LuckyVickyImage
    let profileImage: LuckyVickyImage
    let systemContent: String
    
    static let characters: [CharacterEntity] = [
        CharacterEntity(id: 0, name: "원영", introduction: "완전 럭키비키잖앙~", 
                        nickname: "원영이가", iconImage: .wonyoung,
                        profileImage: .profileWonyoung, systemContent: Config.wonyoungSystemContent),
        CharacterEntity(id: 1, name: "희진", introduction: "맞다이로 들어와",
                        nickname: "나 민희진이", iconImage: .heejin,
                        profileImage: .profileHeejin, systemContent: Config.heejinSystemContent),
        CharacterEntity(id: 2, name: "우희", introduction: "얼마나 잘 되려고 이럴까?",
                        nickname: "우희가", iconImage: .woohee,
                        profileImage: .profileWoohee, systemContent: Config.wooheeSystemContent),
        CharacterEntity(id: 3, name: "흥민", introduction: "그냥 좋다고 생각하면 돼.",
                        nickname: "쏘니가", iconImage: .heungmin,
                        profileImage: .profileHeungmin, systemContent: Config.heungminSystemContent)
    ]
}
