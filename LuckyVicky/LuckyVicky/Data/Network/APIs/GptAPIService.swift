//
//  GptAPIService.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

import Combine

final class GptAPIService {
    
    typealias API = GptAPI
    
    private let provider: NetworkProvider<API>
    
    init(provider: NetworkProvider<API> = NetworkProvider<API>()) {
        self.provider = provider
    }
    
    func createChat(
        systemContent: String,
        userContent: String
    ) -> AnyPublisher<GptResponseDTO, NetworkError> {
        return provider.request(.createChat(systemContent: systemContent, userContent: userContent))
    }
}
