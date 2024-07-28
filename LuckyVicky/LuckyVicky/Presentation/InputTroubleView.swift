//
//  InputTroubleView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct InputTroubleView: View {
    @State private var inputText: String = ""
    @Binding var path: NavigationPath
    let selectedId: Int
    
    var body: some View {
        ZStack {
            Color(.mainBlack).ignoresSafeArea()
            
            VStack(spacing: 0) {
                LuckyVickyNavigationBar(
                    leftItem: (
                        LuckyVickyImage.backArrow, {
                            path.removeLast()
                        }
                    )
                )
                .padding(.bottom, 8)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("털어버리고 싶은\n힘들었던 일을 입력해주세요")
                            .font(.pretendardSB(22))
                            .foregroundStyle(.white)
                            .lineSpacing(10)
                            .padding(.bottom, 15)
                        Text("ex) 오늘 중요한 업무에서 실수를 해버렸어")
                            .font(.pretendardM(12))
                            .foregroundStyle(.white)
                    }
                    .padding(.leading, 28)
                    Spacer()
                }
                
                LuckyVickyTextEditor(
                    text: $inputText,
                    placeholder: "어떤 일이 있었나요?",
                    maxCharacterCount: 100
                )
                .frame(height: 374)
                .overlay(alignment: .bottomTrailing) {
                    Text("\(inputText.count)/100")
                        .font(.pretendardM(14))
                        .foregroundStyle(Color(.gray1))
                        .padding(.trailing, 22)
                        .padding(.bottom, 20)
                }
                .padding(.top, 52)
                .padding(.horizontal, 26)
                
                Spacer()
                LuckyVickyButton(
                    title: "변환하기",
                    isActive: !inputText.isEmpty,
                    action: {
                        path.append(Route.resultView)
                    }
                )
                .padding(.horizontal, 22)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
