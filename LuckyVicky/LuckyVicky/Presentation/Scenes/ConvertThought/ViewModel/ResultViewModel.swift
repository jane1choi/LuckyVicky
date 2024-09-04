//
//  ResultViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/9/24.
//

import Foundation

final class ResultViewModel: ViewModelable {
    @Published var state: State
    private let coordinator: Coordinator
    private let alertPresenter: AlertPresenter
    
    init(coordinator: Coordinator,
         alertPresenter: AlertPresenter
    ) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(characterNickname: CharacterEntity.characters[id].nickname,
                           characterProfile:  CharacterEntity.characters[id].profileImage, 
                           isLoading: false)
        self.coordinator = coordinator
        self.alertPresenter = alertPresenter
    }
    
    enum Action {
        case onTapSaveImageButton(data: Data)
        case onTapPopToRootButton
    }
    
    struct State {
        let characterNickname: String
        let characterProfile: LuckyVickyImage
        var isLoading: Bool
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapSaveImageButton(let data):
            state.isLoading = true
            saveImage(imageData: data)
        case .onTapPopToRootButton:
            coordinator.popToRoot()
        }
    }
}

extension ResultViewModel {
    
    private func saveImage(imageData: Data) {
        let manager = ImageSaver()

        manager.saveToPhotoAlbum(data: imageData) { [weak self] success in
            self?.state.isLoading = false
            self?.alertPresenter.presentAlert(message: success ? .imagehasSaved : .imageSaveError)
        }
    }
}
    


