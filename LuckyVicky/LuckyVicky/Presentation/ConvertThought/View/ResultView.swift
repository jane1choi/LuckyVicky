//
//  ResultView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/26/24.
//

import SwiftUI

struct ResultView: View {
    @StateObject private var viewModel: ResultViewModel
    @Binding var path: NavigationPath
    
    init(viewModel: ResultViewModel, path: Binding<NavigationPath>) {
        self._viewModel = .init(wrappedValue: viewModel)
        self._path = path
    }
    
    var body: some View {
        VStack(spacing: 0) {
            LuckyVickyNavigationBar(
                rightItemList: [
                    (LuckyVickyImage.save, {
                        guard let imageData = resultChatView().convertToImage()
                        else {
                            return
                        }
                        viewModel.action(.onTapSaveImageButton(data: imageData))
                    }), (LuckyVickyImage.share, {})]
            )
            
            resultChatView()
            
            LuckyVickyButton(
                title: "처음으로",
                isActive: true,
                action: {
                    path.removeLast(path.count)
                }
            )
            .padding(.horizontal, 22)
            .padding(.bottom, 12)
        }
        .background(Color(.mainBlack))
        .navigationBarBackButtonHidden()
        .presentAlert(isPresented: $viewModel.state.isAlertPresented) {
            LuckyVickyAlertView(
                isPresented: $viewModel.state.isAlertPresented,
                message: viewModel.state.alertMessage
            )
        }
    }
}

@ViewBuilder 
func resultChatView() -> some View {
    VStack(spacing: 0) {
        Spacer()
            .frame(height: 8)
        HStack {
            VStack(alignment: .leading) {
                Text("초긍정의 힘!\n원영이가 생각하기엔..")
                    .font(.pretendardSB(22))
                    .foregroundStyle(.white)
                    .lineSpacing(10)
                    .padding(.bottom, 15)
                Text("힘든 일은 럭키비키한 생각으로 털어버리자")
                    .font(.pretendardM(12))
                    .foregroundStyle(.white)
            }
            Spacer()
        }
        .padding(.leading, 28)
        .padding(.bottom, 52)
        
        Text("안녕하세요")
            .font(.pretendardM(14))
            .padding(.leading, 20)
            .padding(.trailing, 39)
            .padding(.vertical, 20)
            .frame(minHeight: 100)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(LuckyVickyChatBubble(cornerRadius: 22,
                                            direction: .right))
            .padding(.leading, 42)
            .padding(.trailing, 22)
            .padding(.bottom, 40)
        
        Spacer()
            .frame(height: 40)
        
        HStack(alignment: .top, spacing: 8) {
            Image(LuckyVickyImage.profileWonyoung)
                .frame(width: 42, height: 42)
            
            Text("안녕하세요")
                .font(.pretendardM(14))
                .padding(.leading, 39)
                .padding(.trailing, 20)
                .padding(.vertical, 20)
                .frame(minHeight: 100)
                .frame(maxWidth: .infinity)
                .background(Color(.subGreen))
                .clipShape(LuckyVickyChatBubble(cornerRadius: 22,
                                                direction: .left))
                .padding(.top, 15)
        }
        .padding(.leading, 18)
        .padding(.trailing, 22)
        Spacer()
    }
    .background(Color(.mainBlack))
}
