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
    private let inputText: String
    private let result: String
    
    init(
        viewModel: ResultViewModel,
        path: Binding<NavigationPath>,
        inputText: String,
        result: String
    ) {
        self._viewModel = .init(wrappedValue: viewModel)
        self._path = path
        self.inputText = inputText
        self.result = result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            LuckyVickyNavigationBar(
                rightItemList: [
                    (LuckyVickyImage.save, {
                        guard let imageData = resultChatView(
                            nickname: viewModel.state.characterNickname, 
                            profile: viewModel.state.characterProfile, 
                            userInput: inputText, 
                            result: result
                        ).convertToImage()
                        else {
                            return
                        }
                        viewModel.action(.onTapSaveImageButton(data: imageData))
                    }), (LuckyVickyImage.share, {})]
            )
            
            resultChatView(nickname: viewModel.state.characterNickname, 
                           profile: viewModel.state.characterProfile, 
                           userInput: inputText, 
                           result: result)
            
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
func resultChatView(
    nickname: String,
    profile: LuckyVickyImage,
    userInput: String,
    result: String
) -> some View {
    VStack(spacing: 0) {
        Spacer()
            .frame(height: 8)
        HStack {
            VStack(alignment: .leading) {
                Text("초긍정의 힘!\n\(nickname) 생각하기엔..")
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
        
        Text(userInput)
            .font(.pretendardM(14))
            .lineSpacing(5)
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
            Image(profile)
                .frame(width: 42, height: 42)
            
            Text(result)
                .font(.pretendardM(14))
                .lineSpacing(5)
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
