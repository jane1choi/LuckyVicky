//
//  InputTroubleViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/9/24.
//

import SwiftUI

final class InputTroubleViewModel: ViewModelable {
    @Published var state: State
    
    init() {
        self.state = State(selectedId: 0,
                           inputText: "")
    }
    
    enum Action {
        case isTextEditorEditing(text: String)
    }
    
    struct State {
        var selectedId: Int
        var inputText: String
    }
    
    func action(_ action: Action) {
        switch action {
        case .isTextEditorEditing(let text):
            state.inputText = text
        }
    }
}
