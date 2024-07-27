//
//  LuckyVickyApp.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/11/24.
//

import SwiftUI

@main
struct LuckyVickyApp: App {
    @State private var appRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentroot {
                case .splash:
                    SplashView()
                case .main:
                    SelectCharacterView()
                }
            }
            .environment(appRootManager)
        }
    }
}

@Observable final class AppRootManager {
    var currentroot: AppRoot = .splash
}
