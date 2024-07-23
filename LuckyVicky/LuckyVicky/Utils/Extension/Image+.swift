//
//  Image+.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import SwiftUI

extension Image {
    init(_ imageName: LuckyVickyImage) {
        self = Image(imageName.rawValue, bundle: nil)
    }
}
