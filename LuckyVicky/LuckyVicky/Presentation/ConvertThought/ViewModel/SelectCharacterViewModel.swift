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
        self.state = State(chanceCount: 10,
                           characterList: CharacterEntity.characters,
                           isAlertPresented: false)
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
        case onTapSelectButton
    }
    
    struct State {
        var selectedId: Int?
        var chanceCount: Int
        var characterList: [CharacterEntity]
        var isAlertPresented: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapCharacterCell(let id):
            state.selectedId = id
        case .onTapSelectButton:
            state.isAlertPresented = state.chanceCount <= 0
        }
    }
}
