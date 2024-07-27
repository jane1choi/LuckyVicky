//
//  InputTroubleView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct InputTroubleView: View {
    @State private var inputText: String = ""
    
    var body: some View {
        ZStack {
            Color(.mainBlack).ignoresSafeArea()
            
            VStack(spacing: 0) {
                LuckyVickyNavigationView(
                    leftItem: (LuckyVickyImage.backArrow, {
                        
                    })
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
                
                LuckyVickyTextEditor(text: $inputText,
                                     placeholder: "어떤 일이 있었나요?")
                .frame(height: 374)
                .padding(.top, 52)
                .padding(.horizontal, 26)
                
                Spacer()
                LuckyVickyButton(title: "변환하기",
                                 action: {})
                .padding(.horizontal, 22)

            }
        }
    }
}

#Preview {
    InputTroubleView()
}