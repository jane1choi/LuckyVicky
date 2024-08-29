//
//  SplashView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/27/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color(.mainBlack)
                .ignoresSafeArea()
            Image(LuckyVickyImage.clover)
                .resizable()
                .frame(width: 110, height: 110)
        }
    }
}
