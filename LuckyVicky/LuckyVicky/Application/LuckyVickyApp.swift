//
//  LuckyVickyApp.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/11/24.
//

import SwiftUI

@main
struct LuckyVickyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentflow {
                case .splash:
                    SplashView()
                case .login:
                    let signRepository = SignRepositoryImpl()
                    let userRepository = UserDBRepositoryImpl()
                    let useCase = LoginUseCaseImpl(signRepository: signRepository, userRepository: userRepository)
                    let viewModel = LoginViewModel(useCase: useCase)
                    LoginView(viewModel: viewModel)
                case .main:
                    let useCase = UserDataUseCaseImpl(repository: UserDBRepositoryImpl())
                    let viewModel = SelectCharacterViewModel(useCase: useCase)
                    SelectCharacterView(viewModel: viewModel)
                }
            }
            .environmentObject(appRootManager)
        }
    }
}

final class AppRootManager: ObservableObject {
    @Published var currentflow: AppFlow = .splash
}
