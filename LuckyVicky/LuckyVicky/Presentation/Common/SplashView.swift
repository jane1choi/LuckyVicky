//
//  SplashView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/27/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        ZStack {
            Color(.mainBlack)
                .ignoresSafeArea()
            Image(LuckyVickyImage.clover)
                .resizable()
                .frame(width: 110, height: 110)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.smooth) {
                    appRootManager.currentflow =  UserDefaults.isFirstLaunch ? .login : .main
                }
            }
        }
    }
}
