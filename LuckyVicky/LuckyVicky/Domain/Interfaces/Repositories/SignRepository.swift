//
//  SignRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 9/5/24.
//

import Foundation
import AuthenticationServices
import Combine

protocol SignRepository {
    func checkAuthenticationState() -> String?
    func requestAuthorization(_ request: ASAuthorizationAppleIDRequest) -> String
    func signIn(_ authorization: ASAuthorization, nonce: String) -> AnyPublisher<UserEntity, NetworkError>
}
