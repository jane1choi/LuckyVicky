//
//  FirebaseDBService.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/16/24.
//

import Foundation
import Combine

import FirebaseAuth
import FirebaseDatabase

enum DBError: Error {
    case error(Error)
    case emptyValue
}

final class FirebaseDBService {
    var db: DatabaseReference = Database.database().reference()
    
    private func getPath(key: String, path: String?) -> String {
        if let path {
            return "\(key)/\(path)"
        } else {
            return key
        }
    }
    
    func create(key: String, path: String?, value: Any) -> AnyPublisher<Void, DBError> {
        let path = getPath(key: key, path: path)
        
        return Future<Void, DBError> { [weak self] promise in
            self?.db.child(path).setValue(value) { error, _ in
                if let error {
                    promise(.failure(.error(error)))
                } else {
                    promise (.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetch(key: String, path: String?) -> AnyPublisher<Any?, DBError> {
        let path = getPath(key: key, path: path)
        
        return Future<Any?, DBError> { [weak self] promise in
            self?.db.child(path).getData { error, snapshot in
                if let error {
                    promise(.failure(.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func update(key: String, path: String?, value: [String: Any]) -> AnyPublisher<Void, DBError> {
        let path = getPath(key: key, path: path)
        
        return Future<Void, DBError> { [weak self] promise in
            self?.db.child(path).updateChildValues(value) { error, _ in
                if let error {
                    promise(.failure(.error(error)))
                } else {
                    promise (.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func delete(key: String, path: String?) -> AnyPublisher<Void, DBError> {
        let path = getPath(key: key, path: path)
        
        return Future<Void, DBError> { [weak self] promise in
            self?.db.child(path).removeValue() { error, _ in
                if let error {
                    promise(.failure(.error(error)))
                } else {
                    promise (.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
}
