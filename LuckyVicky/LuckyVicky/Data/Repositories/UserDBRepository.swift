//
//  UserDBRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import Combine

import FirebaseDatabase

enum DBError: Error {
    case error(Error)
    case emptyValue
}

protocol UserDBRepository {
    func createUser(_ dto: UserDTO) -> AnyPublisher<Void, DBError>
    func getUser(userId: String) -> AnyPublisher<UserDTO, DBError>
    func updateUserData(userId: String, value: [String: Any]) -> AnyPublisher<Void, DBError>
}

final class UserDBRepositoryImpl: UserDBRepository {
    var db: DatabaseReference = Database.database().reference()
    
    func createUser(_ dto: UserDTO) -> AnyPublisher<Void, DBError> {
        Just(dto)
            .compactMap { try? JSONEncoder().encode($0) }
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { value in
                Future<Void, Error> { [weak self] promise in
                    self?.db.child("Users").child(dto.id).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError{ DBError.error($0) }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<UserDTO, DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child("Users/\(userId)").getData { error, snapshot in
                if let error {
                    promise(.failure(.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }.flatMap { value in
            if let value {
                return Just(value)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0) }
                    .decode(type: UserDTO.self, decoder: JSONDecoder())
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: .emptyValue).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateUserData(userId: String, value: [String: Any]) -> AnyPublisher<Void, DBError> {
        return Future<Void, DBError> { [weak self] promise in
            self?.db.child("Users/\(userId)").updateChildValues(value) { error, snapshot in
                if let error {
                    promise(.failure(.error(error)))
                } else {
                    promise (.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
