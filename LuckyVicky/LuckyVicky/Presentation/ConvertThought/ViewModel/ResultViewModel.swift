//
//  ResultViewModel.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/9/24.
//

import SwiftUI

final class ResultViewModel: ViewModelable {
    @Published var state: State
    
    init() {
        self.state = State(isAlertPresented: false,
                           alertMessage: "")
    }
    
    enum Action {
        case onTapSaveImageButton(data: Data)
    }
    
    struct State {
        var isAlertPresented: Bool
        var alertMessage: String
    }
    
    func action(_ action: Action) {
        switch action {
        case .onTapSaveImageButton(let data):
            saveImage(imageData: data)
        }
    }
    
    private func saveImage(imageData: Data) {
        let manager = ImageSaveManager()

        manager.saveToPhotoAlbum(data: imageData) { success in
            self.state.alertMessage = success ? "이미지가 사진 앨범에\n저장되었습니다."
            : "이미지 저장에 실패했습니다.\n다시 시도해주세요"
        }
        state.isAlertPresented = true
    }
}


