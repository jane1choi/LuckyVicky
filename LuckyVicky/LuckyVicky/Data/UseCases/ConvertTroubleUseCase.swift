//
//  ConvertTroubleUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import Combine

protocol ConvertTroubleUseCase {
    func execute(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError>
}

final class ConvertTroubleUseCaseImpl: ConvertTroubleUseCase {
    private let gptRepository: GptRepository
    private let userRepository: UserRepository
    
    init(gptRepository: GptRepository,
         userRepository: UserRepository
    ) {
        self.gptRepository = gptRepository
        self.userRepository = userRepository
    }
    
    func execute(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError> {
        return gptRepository
            .fetchResultData(systemContent: systemContent, userContent: userContent)
            .flatMap { [weak self] replyEntity -> AnyPublisher<ReplyEntity, NetworkError> in
                guard let self = self
                else { 
                    return Fail(error: NetworkError.serverError).eraseToAnyPublisher()
                }
                return self.userRepository
                    .updateUserData(userId: UserDefaults.userId,
                                    lastUsedDate: Date().today,
                                    usedCount: UserDefaults.usedCount + 1)
                    .map { _ in replyEntity }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
