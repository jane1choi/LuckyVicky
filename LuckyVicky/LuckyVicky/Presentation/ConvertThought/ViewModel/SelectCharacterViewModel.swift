//
//  SelectCharacterViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/8/24.
//

import Foundation
import Combine

final class SelectCharacterViewModel: ViewModelable {
    @Published var state: State
    private let useCase: UserDataUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: UserDataUseCase) {
        self.state = State(isLoading: false,
                           chanceCount: 0,
                           characterList: CharacterEntity.characters,
                           isAlertPresented: false, 
                           hasErrorOccurred: false)
        self.useCase = useCase
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
        case onTapSelectButton
        case onAppear
    }
    
    struct State {
        var isLoading: Bool
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
            state.isLoading = true
            checkUserChance()
            state.selectedId = nil
        }
    }
}

extension SelectCharacterViewModel {
    
    private func checkUserChance() {
        useCase.fetchUserData(userId: UserDefaults.userId)
            .sink { [weak self] completion in
    
                switch completion {
                case .failure(_):
                    self?.state.isLoading = false
                    self?.state.hasErrorOccurred = true
                case .finished:
                    self?.state.isLoading = false
                }
            } receiveValue: { [weak self] value in
                if value.lastUsedDate != Date().today {
                    self?.state.chanceCount = 0
                    UserDefaults.usedCount = 0
                } else {
                    self?.state.chanceCount = value.usedCount
                    UserDefaults.usedCount = value.usedCount
                }
            }.store(in: &cancellables)

    }
}
