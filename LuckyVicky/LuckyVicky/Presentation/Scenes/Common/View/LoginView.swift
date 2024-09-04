//
//  LoginView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text("초긍정의 힘!\n기분 좋은 오늘을 위한 사고 변환기 ")
                        .font(.pretendardSB(22))
                        .foregroundStyle(.white)
                        .lineSpacing(10)
                        .padding(.bottom, 15)
                    Text("힘든 일, 고민 모두 럭키비키로 해결해보세요")
                        .font(.pretendardM(12))
                        .foregroundStyle(.white)
                }
                Spacer()
            }
            .padding(.leading, 28)
            .padding(.top, 60)

            Image(LuckyVickyImage.chatExample)
                .resizable()
                .scaledToFit()
                .frame(width: 332 * ((screenSize?.width ?? 0) / 375),
                       height: 332 * ((screenSize?.height ?? 0) / 812))
                .padding(.top, 60)
            
            Spacer()
            Text("로그인하고 럭키비키 시작하기")
                .font(.pretendardM(10))
                .foregroundStyle(.white)
                .padding(.bottom, 19)

            SignInWithAppleButton(onRequest: { request in
                viewModel.action(.onTapAppleLoginButton(request: request))
            }, onCompletion: { result in
                viewModel.action(.onCompletedAuthorization(result: result))
            })
            .signInWithAppleButtonStyle(.white)
            .frame(height: 52)
            .cornerRadius(10)
            .padding(.horizontal, 22)
            .padding(.bottom, 12)
        }
        .background(Color(.mainBlack))
        .overlay {
            LoadingView()
                .hidden(!viewModel.state.isLoading)
        }
    }
}
