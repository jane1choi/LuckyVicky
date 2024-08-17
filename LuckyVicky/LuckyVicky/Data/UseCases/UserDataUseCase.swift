//
//  UserDataUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import Combine

protocol UserDataUseCase {
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError>
    func updateUserData(userId: String, lastUsedDate: String, usedCount: Int) -> AnyPublisher<Void, NetworkError>
    func deleteAccount() -> AnyPublisher<Void, NetworkError>
}

final class UserDataUseCaseImpl: UserDataUseCase {
    
    private var repository: UserDBRepository
    
    init(repository: UserDBRepository) {
        self.repository = repository
    }
    
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError> {
        repository.getUser(userId: userId)
            .map { $0.toEntity() }
            .mapError { error in
                print(error)
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
        
        return repository.updateUserData(userId: userId, value: data)
            .mapError { _ in NetworkError.serverError }
            .eraseToAnyPublisher()
    }
    
    func deleteAccount() -> AnyPublisher<Void, NetworkError> {
        repository.deleteUserData(userId: UserDefaults.userId)
            .mapError{ _ in
                return .serverError
            }
            .eraseToAnyPublisher()
    }
}
