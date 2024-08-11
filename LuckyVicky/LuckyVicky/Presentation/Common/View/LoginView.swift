//
//  LoginView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import SwiftUI

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
            
            LuckyVickyButton(
                image: LuckyVickyImage.appleLogo,
                title: "Apple로 로그인",
                isActive: true,
                action: {
                    viewModel.action(.onTapLoginButton)
                }
            )
            .padding(.horizontal, 22)
            .padding(.bottom, 12)
            .fullScreenCover(isPresented: $viewModel.state.isPresented) {
                let viewModel = SelectCharacterViewModel()
                SelectCharacterView(viewModel: viewModel)
            }
        }
        .background(Color(.mainBlack))
        .presentAlert(isPresented: $viewModel.state.hasErrorOccurred) {
            LuckyVickyAlertView(
                isPresented: $viewModel.state.hasErrorOccurred,
                message: "네트워크 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
            )
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
