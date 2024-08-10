//
//  GptResponseDTO.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

struct GptResponseDTO: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let systemFingerprint: String
    let choices: [Choice]
    let usage: Usage
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case model
        case choices
        case usage
        case systemFingerprint = "system_fingerprint"
    }
}

struct Choice: Decodable {
    let index: Int
    let message: Message
    let logprobs: String?
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case index
        case message
        case logprobs
        case finishReason = "finish_reason"
    }
}

struct Usage: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

extension GptResponseDTO {
    func toEntity() -> ReplyEntity {
        let result = self.choices[0].message.content
        return ReplyEntity(reply: result)
    }
}
