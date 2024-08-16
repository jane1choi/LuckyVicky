//
//  LoginViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/11/24.
//

import Foundation
import AuthenticationServices
import Combine

final class LoginViewModel: ViewModelable {
    @Published var state: State
    private let useCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()
    private var currentNonce: String?
    
    init(useCase: LoginUseCase) {
        self.state = State(isLoading: false,
                           isPresented: false,
                           hasErrorOccurred: false)
        self.useCase = useCase
    }
    
    enum Action {
        case onTapAppleLoginButton(request: ASAuthorizationAppleIDRequest)
        case onCompletedAuthorization(result: Result<ASAuthorization, Error>)
    }
    
    struct State {
        var isLoading: Bool
        var isPresented: Bool
        var hasErrorOccurred: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapAppleLoginButton(let request):
            state.isLoading = true
            let nonce = useCase.executeAuthorization(request)
            currentNonce = nonce
        case .onCompletedAuthorization(let result):
            login(result)
        }
    }
}

extension LoginViewModel {
    
    private func login(_ result: Result<ASAuthorization, Error>) {
        if case let .success(authorization) = result {
            guard let nonce = currentNonce else { return }
            
            useCase.executeSignIn(authorization, nonce: nonce)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.state.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.updateStateAfterLoginSuccess(user: user)
                }.store(in: &cancellables)
      
        } else if case let .failure(error) = result {
            state.isLoading = false
            state.hasErrorOccurred = true
        }
    }
    
    private func updateStateAfterLoginSuccess(user: UserEntity) {
        state.isLoading = false
        UserDefaults.userId = user.id
        UserDefaults.usedCount = user.usedCount
        state.isPresented = true
        UserDefaults.isFirstLaunch = false
    }
}

