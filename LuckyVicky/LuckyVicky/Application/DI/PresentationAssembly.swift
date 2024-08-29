//
//  PresentationAssembly.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/29/24.
//

import Swinject

struct PresentationAssembly: Assembly {
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func assemble(container: Container) {
        container.register(LoginViewModel.self) { resolver in
            let loginUseCase = resolver.resolve(LoginUseCaseImpl.self)!
            return LoginViewModel(coordinator: coordinator, useCase: loginUseCase)
        }
        container.register(SelectCharacterViewModel.self) { resolver in
            let fetchUserDataUseCase = resolver.resolve(FetchUserDataUseCaseImpl.self)!
            let deleteAccountUseCase = resolver.resolve(DeleteAccountUseCaseImpl.self)!
            return SelectCharacterViewModel(coordinator: coordinator,
                                            fetchUserDataUseCase: fetchUserDataUseCase,
                                            deleteAccountUseCase: deleteAccountUseCase)
        }
        container.register(InputTroubleViewModel.self) { resolver in
            let convertTroubleUseCase = resolver.resolve(ConvertTroubleUseCaseImpl.self)!
            return InputTroubleViewModel(coordinator: coordinator, convertTroubleUseCase: convertTroubleUseCase)
        }
        container.register(ResultViewModel.self) { _ in
            return ResultViewModel(coordinator: coordinator)
        }
        
        container.register(LoginView.self) { resolver in
            let viewModel = resolver.resolve(LoginViewModel.self)!
            return LoginView(viewModel: viewModel)
        }
        
        container.register(SelectCharacterView.self) { resolver in
            let viewModel = resolver.resolve(SelectCharacterViewModel.self)!
            return SelectCharacterView(viewModel: viewModel)
        }
        
        container.register(InputTroubleView.self) { resolver in
            let viewModel = resolver.resolve(InputTroubleViewModel.self)!
            return InputTroubleView(viewModel: viewModel)
        }
        
        container.register(ResultView.self) { (resolver, inputText: String, result: String) in
            let viewModel = resolver.resolve(ResultViewModel.self)!
            return ResultView(viewModel: viewModel, inputText: inputText, result: result)
        }
    }
}
