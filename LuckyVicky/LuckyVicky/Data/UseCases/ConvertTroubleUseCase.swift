//
//  ConvertTroubleUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import Combine

protocol ConvertTroubleUseCase {
    func fetchResultData(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError>
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError>
    func updateUserData(userId: String, lastUsedDate: String, usedCount: Int) -> AnyPublisher<Void, NetworkError>
}

final class ConvertTroubleUseCaseImpl: ConvertTroubleUseCase {
    private let gptRepository: GptRepository
    private let userRepository: UserDBRepository
    
    init(gptRepository: GptRepository, userRepository: UserDBRepository) {
        self.gptRepository = gptRepository
        self.userRepository = userRepository
    }
    
    func fetchResultData(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError> {
        gptRepository.fetchResultData(systemContent: systemContent,
                                      userContent: userContent)
        .map { $0.toEntity() }
        .eraseToAnyPublisher()
    }
    
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError> {
        userRepository.getUser(userId: userId)
            .map { $0.toEntity() }
            .mapError { error in
                return .serverError
            }
            .eraseToAnyPublisher()
    }
    
    func updateUserData(
        userId: String,
        lastUsedDate: String,
        usedCount: Int
    ) -> AnyPublisher<Void, NetworkError> {
        let data: [String: Any] = [
            "lastUsedDate": lastUsedDate,
            "usedCount": usedCount
        ]
        
        return userRepository.updateUserData(userId: userId, value: data)
            .mapError { _ in NetworkError.serverError }
            .eraseToAnyPublisher()
    }
}
