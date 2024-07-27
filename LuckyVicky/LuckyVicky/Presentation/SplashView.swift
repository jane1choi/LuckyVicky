//
//  SplashView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/27/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(AppRootManager.self) private var appRootManager
    
    var body: some View {
        ZStack {
            Color(.mainBlack)
                .ignoresSafeArea()
            Image(LuckyVickyImage.clover)
                .frame(width: 110, height: 110)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 2)) {
                    appRootManager.currentroot = .main
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
