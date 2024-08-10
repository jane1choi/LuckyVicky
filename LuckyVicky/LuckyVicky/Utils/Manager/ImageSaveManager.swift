//
//  ImageSaveManager.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/9/24.
//

import SwiftUI

final class ImageSaveManager: NSObject {
    private var completion: ((Bool) -> Void)?
    
    func saveToPhotoAlbum(data: Data, completion: @escaping (Bool) -> Void) {
        guard let image = UIImage(data: data) else {
            completion(false)
            return
        }
        
        self.completion = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(
        _ image: UIImage,
        didFinishSavingWithError error: Error?,
        contextInfo: UnsafeRawPointer
    ) {
        completion?(error == nil)
    }
}
