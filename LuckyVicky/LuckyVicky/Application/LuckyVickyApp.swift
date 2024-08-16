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
                    let viewModel = LoginViewModel()
                    LoginView(viewModel: viewModel)
                case .main:
                    let viewModel = SelectCharacterViewModel()
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
