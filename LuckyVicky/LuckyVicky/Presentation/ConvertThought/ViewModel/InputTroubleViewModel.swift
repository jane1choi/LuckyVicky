//
//  InputTroubleViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/9/24.
//

import Foundation
import Combine

final class InputTroubleViewModel: ViewModelable {
    @Published var state: State
    private let repository: GptRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: GptRepository) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(characterContent: CharacterEntity.characters[id].systemContent,
                           inputText: "", 
                           result: "", 
                           hasErrorOccurred: false, 
                           onCompleted: false)
        self.repository = repository
    }
    
    enum Action {
        case isTextEditorEditing(text: String)
        case onTapConvertButton
    }
    
    struct State {
        let characterContent: String
        var inputText: String
        var result: String
        var hasErrorOccurred: Bool
        var onCompleted: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .isTextEditorEditing(let text):
            state.inputText = text
        case .onTapConvertButton:
            fetchData(systemContent: state.characterContent,
                      userContent: state.inputText)
        }
    }
}

extension InputTroubleViewModel {
    
    private func fetchData(
        systemContent: String,
        userContent: String
    ) {
        repository.fetchResultData(systemContent: systemContent,
                                   userContent: userContent)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.state.hasErrorOccurred = false
            case .failure(let error):
                self?.state.hasErrorOccurred = true
            }
        }, receiveValue: { [weak self] result in
            self?.state.result = result.reply
            self?.state.onCompleted = true
        }).store(in: &cancellables)
    }
}
