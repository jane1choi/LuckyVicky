//
//  LoginUseCase.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import AuthenticationServices
import Combine

protocol LoginUseCase {
    func executeAuthorization(_ request: ASAuthorizationAppleIDRequest) -> String
    func executeSignIn(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<UserEntity, NetworkError>
}

final class LoginUseCaseImpl: LoginUseCase {
    private let signRepository: SignRepository
    private let userRepository: UserRepository
    
    init(signRepository: SignRepository, userRepository: UserRepository) {
        self.signRepository = signRepository
        self.userRepository = userRepository
    }
    
    func executeAuthorization(_ request: ASAuthorizationAppleIDRequest) -> String {
        return signRepository.requestAuthorization(request)
    }
    
    func executeSignIn(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<UserEntity, NetworkError> {
        if let uuid = signRepository.checkAuthenticationState() {
            return userRepository.fetchUserData(userId: uuid)
                .catch { [weak self] _ -> AnyPublisher<UserEntity, NetworkError> in
                    guard let self = self else {
                        return Empty().eraseToAnyPublisher()
                    }
                    return self.signUp(authorization, nonce: nonce)
                }
                .eraseToAnyPublisher()
        } else {
            return signUp(authorization, nonce: nonce)
        }
    }
}

extension LoginUseCaseImpl {
    
    private func signUp(_ authorization: ASAuthorization,
                        nonce: String
    ) -> AnyPublisher<UserEntity, NetworkError> {
        return signRepository.signIn(authorization, nonce: nonce)
            .mapError { _ in
                NetworkError.unauthorized
            }
            .flatMap { [weak self] user -> AnyPublisher<UserEntity, NetworkError> in
                guard let self = self
                else {
                    return Empty().eraseToAnyPublisher()
                }
                return self.userRepository.createUser(user.toDTO())
                    .map{ _ in user }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
