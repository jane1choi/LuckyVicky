//
//  GptAPI.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

import Moya

enum GptAPI {
    case createChat(systemContent: String, 
                    userContent: String)
}

extension GptAPI: BaseAPI {
    
    var urlPath: String {
        switch self {
        case .createChat:
            return "/v1/chat/completions"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createChat:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .createChat:
            return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createChat(let systemContent,
                         let userContent):
            let body = GptRequestDTO(model: GptModel.main.rawValue,
                                       messages: [
                                        Message(role: .system, content: systemContent),
                                        Message(role: .user, content: userContent)
                                       ])
            return body
        }
    }
    
    var sampleData: Data {
        switch self {
        case .createChat:
            let sampleJSON = """
                {
                    "id": "chatcmpl-123",
                    "object": "chat.completion",
                    "created": 1677652288,
                    "model": "gpt-4o-mini",
                    "system_fingerprint": "fp_44709d6fcb",
                    "choices": [{
                        "index": 0,
                        "message": {
                            "role": "assistant",
                            "content": "hello"
                        },
                        "logprobs": null,
                        "finish_reason": "stop"
                    }],
                    "usage": {
                        "prompt_tokens": 9,
                        "completion_tokens": 12,
                        "total_tokens": 21
                    }
                }
                """
            return Data(sampleJSON.utf8)
        }
    }
}
