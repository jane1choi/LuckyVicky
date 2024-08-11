//
//  LoginViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/11/24.
//

import Foundation

final class LoginViewModel: ViewModelable {
    @Published var state: State
    
    init() {
        self.state = State(isPresented: false, 
                           hasErrorOccurred: false)
    }
    
    enum Action {
        case onTapLoginButton
    }
    
    struct State {
        var isPresented: Bool
        var hasErrorOccurred: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        
        case .onTapLoginButton:
            state.isPresented = true
            login()
        }
    }
}

extension LoginViewModel {
    
    private func login() {
        UserDefaults.isFirstLaunch = false
        // TODO: 로그인 및 초기 데이터 세팅 (오늘 사용 가능 횟수)
    }
}

