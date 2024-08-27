//
//  GptRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation
import Combine

protocol GptRepository {
    func fetchResultData(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError>
}

final class GptRepositoryImpl: GptRepository {
    private let apiService: GptAPIService
    
    init(apiService: GptAPIService) {
        self.apiService = apiService
    }
    
    func fetchResultData(
        systemContent: String,
        userContent: String
    ) -> AnyPublisher<ReplyEntity, NetworkError> {
        return apiService
            .createChat(systemContent: systemContent,
                        userContent: userContent)
            .map { dto in
                return dto.toEntity()
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
