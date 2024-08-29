//
//  LuckyVickyApp.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/11/24.
//

import SwiftUI

import Swinject

@main
struct LuckyVickyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var coordinator: MainCoordinator
    private let injector: Injector
    
    init() {
        coordinator = MainCoordinator(UserDefaults.isFirstLaunch ? .login: .selectCharacter)
        injector = DependencyInjector(container: Container())
        injector.assemble([DomainAssembly(),
                           DataAssembly(),
                           PresentationAssembly(coordinator: coordinator)
                          ])
        coordinator.injector = injector
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.buildInitialScene()
                    .navigationDestination(for: AppScene.self) { scene in
                        coordinator.buildScene(scene: scene)
                    }
                    .fullScreenCover(item: $coordinator.sheet) { scene in
                        coordinator.buildScene(scene: scene)
                    }
            }
        }
    }
}
