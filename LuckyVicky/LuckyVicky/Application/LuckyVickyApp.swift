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
                    let signService = SignService()
                    let dbService = FirebaseDBService()
                    let signRepository = SignRepositoryImpl(service: signService)
                    let userRepository = UserRepositoryImpl(service: dbService)
                    let useCase = LoginUseCaseImpl(signRepository: signRepository, userRepository: userRepository)
                    let viewModel = LoginViewModel(useCase: useCase)
                    LoginView(viewModel: viewModel)
                case .main:
                    let dbService = FirebaseDBService()
                    let userRepository = UserRepositoryImpl(service: dbService)
                    let fetchUserDataUseCase = FetchUserDataUseCaseImpl(userRepository: userRepository)
                    let deleteAccountUseCase = DeleteAccountUseCaseImpl(userRepository: userRepository)
                    let viewModel = SelectCharacterViewModel(fetchUserDataUseCase: fetchUserDataUseCase,
                                                             deleteAccountUseCase: deleteAccountUseCase)
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
