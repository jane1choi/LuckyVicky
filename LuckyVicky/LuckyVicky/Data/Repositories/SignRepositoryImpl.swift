//
//  SignRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/26/24.
//

import Foundation
import AuthenticationServices
import Combine

final class SignRepositoryImpl: SignRepository {
    
    private let service: SignService
    
    init(service: SignService) {
        self.service = service
    }
    
    func checkAuthenticationState() -> String? {
        return service.checkAuthenticationState()
    }
    
    func requestAuthorization(_ request: ASAuthorizationAppleIDRequest) -> String {
        return service.handleSignInWithAppleRequest(request)
    }
    
    func signIn(_ authorization: ASAuthorization, 
                nonce: String
    ) -> AnyPublisher<UserEntity, NetworkError> {
        service.handleSignInWithAppleCompletion(authorization, none: nonce)
            .mapError { _ in
                NetworkError.unauthorized
            }
            .map { $0.toEntity() }
            .eraseToAnyPublisher()
    }
}

