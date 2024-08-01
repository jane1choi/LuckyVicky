//
//  GptRequestDTO.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

struct GptRequestDTO: Encodable {
    let model: String
    let messages: [Message]
}
