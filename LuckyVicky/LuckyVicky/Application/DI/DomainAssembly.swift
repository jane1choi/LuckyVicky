//
//  DomainAssembly.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/29/24.
//

import Swinject

struct DomainAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LoginUseCaseImpl.self) { resolver in
            let signRepository = resolver.resolve(SignRepositoryImpl.self)!
            let userRepository = resolver.resolve(UserRepositoryImpl.self)!
            return LoginUseCaseImpl(signRepository: signRepository, userRepository: userRepository)
        }
        container.register(DeleteAccountUseCaseImpl.self) { resolver in
            let userRepository = resolver.resolve(UserRepositoryImpl.self)!
            return DeleteAccountUseCaseImpl(userRepository: userRepository)
        }
        container.register(ConvertTroubleUseCaseImpl.self) { resolver in
            let gptRepository = resolver.resolve(GptRepositoryImpl.self)!
            let userRepository = resolver.resolve(UserRepositoryImpl.self)!
            return ConvertTroubleUseCaseImpl(gptRepository: gptRepository, userRepository: userRepository)
        }
        container.register(FetchUserDataUseCaseImpl.self) { resolver in
            let userRepository = resolver.resolve(UserRepositoryImpl.self)!
            return FetchUserDataUseCaseImpl(userRepository: userRepository)
        }
    }
}

