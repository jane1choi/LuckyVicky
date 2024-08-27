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
    private let fetchUserDataUseCase: FetchUserDataUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchUserDataUseCase: FetchUserDataUseCase,
         deleteAccountUseCase: DeleteAccountUseCase
    ) {
        self.state = State(isLoading: false,
                           chanceCount: 0,
                           characterList: CharacterEntity.characters,
                           isAlertPresented: false, 
                           isDeleteAccountAlertPresented: false, 
                           hasErrorOccurred: false, 
                           hasAccountDeleted: false)
        self.fetchUserDataUseCase = fetchUserDataUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
        case onTapSelectButton
        case onAppear
        case onTapSettingButton
        case onTapdeleteAccountButton
    }
    
    struct State {
        var isLoading: Bool
        var selectedId: Int?
        var chanceCount: Int
        var characterList: [CharacterEntity]
        var isAlertPresented: Bool
        var isDeleteAccountAlertPresented: Bool
        var hasErrorOccurred: Bool
        var hasAccountDeleted: Bool
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
        case .onTapSettingButton:
            state.isDeleteAccountAlertPresented = true
        case .onTapdeleteAccountButton:
            state.isLoading = true
            deleteAccountUseCase.execute()
                .delay(for: .seconds(2), scheduler: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(_):
                        self?.state.isLoading = false
                        self?.state.hasErrorOccurred = true
                    case .finished:
                        self?.state.isLoading = false
                    }
                } receiveValue: { [weak self] _ in
                    UserDefaults.standard.removeAllUserDefaulsKeys()
                    self?.state.hasAccountDeleted = true
                }.store(in: &cancellables)
            
        }
    }
}

extension SelectCharacterViewModel {
    
    private func checkUserChance() {
        fetchUserDataUseCase.execute(userId: UserDefaults.userId)
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
