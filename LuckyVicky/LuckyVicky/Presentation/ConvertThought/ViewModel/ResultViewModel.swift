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
    
    init(coordinator: Coordinator) {
        let id = UserDefaults.selectedCharacterId
        self.state = State(isAlertPresented: false,
                           alertMessage: "",
                           characterNickname: CharacterEntity.characters[id].nickname,
                           characterProfile:  CharacterEntity.characters[id].profileImage, 
                           isLoading: false)
        self.coordinator = coordinator
    }
    
    enum Action {
        case onTapSaveImageButton(data: Data)
        case onTapPopToRootButton
    }
    
    struct State {
        var isAlertPresented: Bool
        var alertMessage: String
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
            self?.state.alertMessage = success ? "이미지가 사진 앨범에\n저장되었습니다."
            : "이미지 저장에 실패했습니다.\n다시 시도해주세요"
            self?.state.isLoading = false
            self?.state.isAlertPresented = true
        }
    }
}
    


