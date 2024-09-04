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
    private let alertPresenter: AlertPresenter
    private let convertTroubleUseCase: ConvertTroubleUseCase
    
    init(coordinator: Coordinator,
         alertPresenter: AlertPresenter,
         convertTroubleUseCase: ConvertTroubleUseCase
    ) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(characterContent: CharacterEntity.characters[id].systemContent,
                           inputText: "",
                           isLoading: false)
        self.convertTroubleUseCase = convertTroubleUseCase
        self.coordinator = coordinator
        self.alertPresenter = alertPresenter
    }
    
    enum Action {
        case isTextEditorEditing(text: String)
        case onTapConvertButton
        case onTapBackButton
    }
    
    struct State {
        let characterContent: String
        var inputText: String
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
                self?.alertPresenter.presentAlert(message: .networkError)
            }
            self?.state.isLoading = false
        }, receiveValue: { [weak self] result in
            self?.coordinator.push(.result(userInput: self?.state.inputText ?? "", result: result.reply))
        }).store(in: &cancellables)
    }
}
