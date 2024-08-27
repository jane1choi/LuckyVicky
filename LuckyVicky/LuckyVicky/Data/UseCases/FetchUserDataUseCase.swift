//
//  FetchUserDataUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/26/24.
//

import Foundation
import Combine

protocol FetchUserDataUseCase {
    func execute(userId: String) -> AnyPublisher<UserEntity, NetworkError>
}

final class FetchUserDataUseCaseImpl: FetchUserDataUseCase {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(userId: String) -> AnyPublisher<UserEntity, NetworkError> {
        return userRepository.fetchUserData(userId: userId)
    }
}
