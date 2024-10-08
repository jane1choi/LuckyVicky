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
    private let coordinator: Coordinator
    private let alertPresenter: AlertPresenter
    private let fetchUserDataUseCase: FetchUserDataUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: Coordinator,
         alertPresenter: AlertPresenter,
         fetchUserDataUseCase: FetchUserDataUseCase,
         deleteAccountUseCase: DeleteAccountUseCase
    ) {
        self.state = State(isLoading: false,
                           chanceCount: 0,
                           characterList: CharacterEntity.characters)
        self.coordinator = coordinator
        self.fetchUserDataUseCase = fetchUserDataUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
        self.alertPresenter = alertPresenter
    }
    
    enum Action {
        case onTapCharacterCell(id: Int)
        case onTapSelectButton
        case onAppear
        case onTapSettingButton
    }
    
    struct State {
        var isLoading: Bool
        var selectedId: Int?
        var chanceCount: Int
        var characterList: [CharacterEntity]
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapCharacterCell(let id):
            state.selectedId = id
        case .onTapSelectButton:
            UserDefaults.selectedCharacterId = state.selectedId ?? 0
            if state.chanceCount < 10 {
                coordinator.push(.inputTrouble)
            } else {
                alertPresenter.presentAlert(message: .exhaustedChance)
            }
        case .onAppear:
            state.isLoading = true
            checkUserChance()
            state.selectedId = nil
        case .onTapSettingButton:
            alertPresenter
                .presentTwoButtonAlert(
                    title: .deleteAccountTitle,
                    message: .deleteAccount,
                    action: { [weak self] in
                        self?.deleteUserAccount()
                    }
                )
        }
    }
}
    
extension SelectCharacterViewModel {
    
    private func deleteUserAccount() {
        state.isLoading = true
        deleteAccountUseCase.execute()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.state.isLoading = false
                    self?.alertPresenter.presentAlert(message: .networkError)
                case .finished:
                    self?.state.isLoading = false
                }
            } receiveValue: { [weak self] _ in
                UserDefaults.standard.removeAllUserDefaulsKeys()
                self?.coordinator.start(with: .login)
            }.store(in: &cancellables)
    }
    
    private func checkUserChance() {
        fetchUserDataUseCase.execute(userId: UserDefaults.userId)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.state.isLoading = false
                    self?.alertPresenter.presentAlert(message: .networkError)
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
