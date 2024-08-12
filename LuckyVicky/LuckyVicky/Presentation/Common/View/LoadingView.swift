//
//  LoadingView.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/12/24.
//

import SwiftUI

struct LoadingView: View {
    private let tintColor: Color
    private let scaleSize: CGFloat
    
    init(
        tintColor: Color = .mainGreen,
        scaleSize: CGFloat = 1.5
    ) {
        self.tintColor = tintColor
        self.scaleSize = scaleSize
    }
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}
