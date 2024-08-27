//
//  DeleteAccountUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/27/24.
//

import Foundation
import Combine

protocol DeleteAccountUseCase {
    func execute() -> AnyPublisher<Void, NetworkError>
}

final class DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> AnyPublisher<Void, NetworkError> {
        userRepository.deleteUserData(userId: UserDefaults.userId)
            .mapError{ _ in
                return .serverError
            }
            .eraseToAnyPublisher()
    }
}
