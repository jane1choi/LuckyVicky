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
    private let coordinator: Coordinator
    private let convertTroubleUseCase: ConvertTroubleUseCase
    
    init(coordinator: Coordinator, convertTroubleUseCase: ConvertTroubleUseCase) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(characterContent: CharacterEntity.characters[id].systemContent,
                           inputText: "",
                           hasErrorOccurred: false, 
                           isLoading: false)
        self.convertTroubleUseCase = convertTroubleUseCase
        self.coordinator = coordinator
    }
    
    enum Action {
        case isTextEditorEditing(text: String)
        case onTapConvertButton
        case onTapBackButton
    }
    
    struct State {
        let characterContent: String
        var inputText: String
//        var result: String
        var hasErrorOccurred: Bool
//        var onCompleted: Bool
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
        case .onTapBackButton:
            coordinator.pop()
        }
    }
}

extension InputTroubleViewModel {
    
    private func fetchData(
        systemContent: String,
        userContent: String
    ) {
        convertTroubleUseCase
            .execute(systemContent: systemContent,userContent: userContent)
        .sink(receiveCompletion: { [weak self] completion in
            if case .failure(_) = completion {
                self?.state.hasErrorOccurred = true
            }
            self?.state.isLoading = false
        }, receiveValue: { [weak self] result in
//            self?.state.result = result.reply
            self?.coordinator.push(.result(userInput: self?.state.inputText ?? "", result: result.reply))
//            self?.state.onCompleted = true
        }).store(in: &cancellables)
    }
}
