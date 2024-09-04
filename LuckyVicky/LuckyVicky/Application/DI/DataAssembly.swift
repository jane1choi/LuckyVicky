//
//  DataAssembly.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/29/24.
//

import Swinject

struct DataAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SignService.self) { _ in
            return SignService()
        }
        container.register(FirebaseDBService.self) { _ in
            return FirebaseDBService()
        }
        container.register(GptAPIService.self) { _ in
            return GptAPIService()
        }
        
        container.register(GptRepositoryImpl.self) { resolver in
            let service = resolver.resolve(GptAPIService.self)!
            return GptRepositoryImpl(apiService: service)
        }
        container.register(UserRepositoryImpl.self) { resolver in
            let service = resolver.resolve(FirebaseDBService.self)!
            return UserRepositoryImpl(service: service)
        }
        container.register(SignRepositoryImpl.self) { resolver in
            let service = resolver.resolve(SignService.self)!
            return SignRepositoryImpl(service: service)
        }
    }
}
