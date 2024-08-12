//
//  SelectCharacterViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/8/24.
//

import Foundation

final class SelectCharacterViewModel: ViewModelable {
    @Published var state: State
    
    init() {
        self.state = State(chanceCount: 0,
                           characterList: CharacterEntity.characters,
                           isAlertPresented: false, 
                           hasErrorOccurred: false)
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
        case onTapSelectButton
        case onAppear
    }
    
    struct State {
        var selectedId: Int?
        var chanceCount: Int
        var characterList: [CharacterEntity]
        var isAlertPresented: Bool
        var hasErrorOccurred: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapCharacterCell(let id):
            state.selectedId = id
        case .onTapSelectButton:
            UserDefaults.selectedCharacterId = state.selectedId ?? 0
            state.isAlertPresented = state.chanceCount >= 10
        case .onAppear:
            checkUserChance()
            state.selectedId = nil
        }
    }
}

extension SelectCharacterViewModel {
    
    private func checkUserChance() {
        
    }
}
