//
//  SignRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/13/24.
//

import Foundation
import AuthenticationServices
import CryptoKit
import Combine

import FirebaseAuth

enum AuthenticationError: Error {
    case clientIDError
    case tokenError
    case invalidated
}

protocol SignRepository {
    func checkAuthenticationState() -> String?
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) -> String
    func handleSignInWithAppleCompletion(_ authorization: ASAuthorization, none: String) -> AnyPublisher<UserDTO, AuthenticationError>
}

final class SignRepositoryImpl: SignRepository {

    func checkAuthenticationState() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid 
        } else {
            return nil
        }
    }
    
    func handleSignInWithAppleRequest(
        _ request: ASAuthorizationAppleIDRequest
    ) -> String {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        return nonce
    }
    
    func handleSignInWithAppleCompletion(
        _ authorization: ASAuthorization,
        none: String
    ) -> AnyPublisher<UserDTO, AuthenticationError> {
        Future { [weak self] promise in
            self?.handleSignInWithAppleCompletion(authorization, nonce: none) { result in
                switch result {
                case let .success(user):
                    promise(.success(user))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension SignRepositoryImpl {
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func handleSignInWithAppleCompletion(
        _ authorization: ASAuthorization,
        nonce: String,
        completion: @escaping (Result<UserDTO, AuthenticationError>) -> Void
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let appleIDToken = appleIDCredential.identityToken 
        else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) 
        else {
            completion(.failure(AuthenticationError.tokenError))
            return
        }
        
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)
        
        authenticateUserWithFirebase(credential: credential) { result in
            switch result {
            case let .success(user):
                completion(.success(user))
            case let .failure(error):
                completion(.failure(AuthenticationError.clientIDError))
            }
        }
    }
    
    private func authenticateUserWithFirebase(
        credential: AuthCredential,
        completion: @escaping (Result<UserDTO, Error>) -> Void
    ) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let result else {
                completion(.failure(AuthenticationError.invalidated))
                return
            }
            
            let firebaseUser = result.user
            
            let user: UserDTO = .init(id: firebaseUser.uid,
                                      name: firebaseUser.displayName ?? "",
                                      usedCount: 0,
                                      lastUsedDate: "")
            
            completion(.success(user))
        }
    }
}
