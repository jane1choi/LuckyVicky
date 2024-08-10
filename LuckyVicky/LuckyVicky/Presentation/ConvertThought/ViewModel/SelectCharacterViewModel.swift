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
        self.state = State(characterList: CharacterEntity.characters)
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
    }
    
    struct State {
        var selectedId: Int?
        var characterList: [CharacterEntity]
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapCharacterCell(let id):
            state.selectedId = id
        }
    }
}
