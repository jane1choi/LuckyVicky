//
//  NetworkEnvironment.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

enum NetworkEnvironment {
    static let baseURL = "https://api.openai.com"
}

extension NetworkEnvironment {
    
    enum HTTPHeaderFields {
        static let `default`: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(Config.openAiAPIKey)"
        ]
    }
}
