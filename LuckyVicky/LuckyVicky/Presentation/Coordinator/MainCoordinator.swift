//
//  MainCoordinator.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/30/24.
//

import SwiftUI

final class MainCoordinator: ObservableObject, Coordinator {
    
    @Published var path: NavigationPath
    @Published var sheet: AppScene?
    private let initialScene: AppScene
    var injector: Injector?
    
    init(_ initialScene: AppScene) {
        self.initialScene = initialScene
        self.path = NavigationPath()
    }
    
    func buildInitialScene() -> some View {
        return buildScene(scene: initialScene)
    }
    
    func push(_ scene: AppScene) {
        path.append(scene)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: AppScene) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
}

extension MainCoordinator {
    
    @ViewBuilder
    func buildScene(scene: AppScene) -> some View {
        switch scene {
        case .login:
            injector?.resolve(LoginView.self)
        case .selectCharacter:
            injector?.resolve(SelectCharacterView.self)
        case .inputTrouble:
            injector?.resolve(InputTroubleView.self)
        case .result(let userInput, let result):
            injector?.resolve(ResultView.self, arguments: userInput, result)
        }
    }
    
    @ViewBuilder
    func buildSheet(scene: AppScene) -> some View {
        NavigationStack {
            buildScene(scene: scene)
        }
    }
}
