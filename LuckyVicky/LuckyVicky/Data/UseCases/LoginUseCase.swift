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
    private let userRepository: UserDBRepository
    
    init(signRepository: SignRepository, userRepository: UserDBRepository) {
        self.signRepository = signRepository
        self.userRepository = userRepository
    }
    
    func executeAuthorization(_ request: ASAuthorizationAppleIDRequest) -> String {
        return signRepository.handleSignInWithAppleRequest(request)
    }
    
    func executeSignIn(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<UserEntity, NetworkError> {
        if let uuid = signRepository.checkAuthenticationState() {
            return fetchUserData(userId: uuid)
        } else {
            return signRepository.handleSignInWithAppleCompletion(authorization, none: nonce)
                .mapError { _ in
                    NetworkError.unauthorized
                }
                .flatMap { [weak self] user -> AnyPublisher<UserEntity, NetworkError> in
                    guard let self = self
                    else {
                        return Empty().eraseToAnyPublisher()
                    }
                    return self.createUser(user.toEntity())
                }
                .eraseToAnyPublisher()
        }
    }
}

extension LoginUseCaseImpl {
    private func fetchUserData(userId: String) -> AnyPublisher<UserEntity, NetworkError> {
        userRepository.getUser(userId: userId)
            .map { $0.toEntity() }
            .mapError { error in
                print(error)
                return .serverError
            }
            .eraseToAnyPublisher()
    }
    
    private func createUser(_ user: UserEntity) -> AnyPublisher<UserEntity, NetworkError> {
        userRepository.createUser(user.toDTO())
            .map { user }
            .mapError { _ in
                return .serverError
            }
            .eraseToAnyPublisher()
    }
}
