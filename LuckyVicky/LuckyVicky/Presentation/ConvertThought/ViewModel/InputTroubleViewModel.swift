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
    private var cancellables = Set<AnyCancellable>()
    private let useCase: ConvertTroubleUseCase
    
    init(useCase: ConvertTroubleUseCase) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(characterContent: CharacterEntity.characters[id].systemContent,
                           inputText: "", 
                           result: "", 
                           hasErrorOccurred: false, 
                           onCompleted: false,
                           isLoading: false)
        self.useCase = useCase
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
        var isLoading: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .isTextEditorEditing(let text):
            state.inputText = text
        case .onTapConvertButton:
            state.isLoading = true
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
        useCase.fetchResultData(systemContent: systemContent,
                                   userContent: userContent)
        .sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.saveData()
            case .failure(_):
                self?.state.hasErrorOccurred = true
            }
            self?.state.isLoading = false
        }, receiveValue: { [weak self] result in
            self?.state.result = result.reply
            self?.state.onCompleted = true
        }).store(in: &cancellables)
    }
    
    private func saveData() {
        useCase.updateUserData(userId: UserDefaults.userId,
                               lastUsedDate: Date().today,
                               usedCount: UserDefaults.usedCount + 1)
        .sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.state.hasErrorOccurred = true
            }
        },
              receiveValue: { }
        ).store(in: &cancellables)
    }
}
