//
//  UserRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/26/24.
//

import Foundation
import Combine

final class UserRepositoryImpl: UserRepository {
    
    private var service: FirebaseDBService
    private let dbKey = "Users"
    
    init(service: FirebaseDBService) {
        self.service = service
    }
    
    func createUser(_ dto: UserDTO) -> AnyPublisher<Void, NetworkError> {
        Just(dto)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { [weak self] value -> AnyPublisher<Void, DBError> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                return self.service.create(key: dbKey, path: dto.id, value: value)
            }
            .mapError { _ in NetworkError.serverError }
            .eraseToAnyPublisher()
    }
    
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError> {
        service.fetch(key: dbKey, path: userId)
            .mapError { _ in NetworkError.serverError}
            .flatMap { value in
                if let value {
                    return Just(value)
                        .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                        .decode(type: UserDTO.self, decoder: JSONDecoder())
                        .map { $0.toEntity() }
                        .mapError { _ in NetworkError.serverError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
                }
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
        
        return service.update(key: dbKey, path: userId, value: data)
            .mapError { _ in NetworkError.serverError }
            .eraseToAnyPublisher()
    }
    
    func deleteUserData(userId: String) -> AnyPublisher<Void, NetworkError> {
        service.delete(key: dbKey, path: userId)
            .mapError{ _ in
                return .serverError
            }
            .eraseToAnyPublisher()
    }
}
