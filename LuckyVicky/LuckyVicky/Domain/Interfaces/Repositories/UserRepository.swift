//
//  UserRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 9/5/24.
//

import Foundation
import Combine

protocol UserRepository {
    func createUser(_ dto: UserDTO) -> AnyPublisher<Void, NetworkError>
    func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError>
    func updateUserData(userId: String, lastUsedDate: String, usedCount: Int) -> AnyPublisher<Void, NetworkError>
    func deleteUserData(userId: String) -> AnyPublisher<Void, NetworkError>
}
