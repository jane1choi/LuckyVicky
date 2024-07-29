//
//  LuckyVickyAlertView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/29/24.
//

import SwiftUI

struct LuckyVickyAlertView: View {
    @Binding var isPresented: Bool
    private let message: String
    
    init(
        isPresented: Binding<Bool>,
        message: String
    ) {
        self._isPresented = isPresented
        self.message = message
    }
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Text(message)
                    .foregroundStyle(.black)
                    .font(.pretendardM(14))
                    .lineSpacing(8)
                    .multilineTextAlignment(.center)
                    .padding(.top, 38)
                Spacer()
                LuckyVickyButton(
                    size: .popUp,
                    title: "확인",
                    isActive: true,
                    action: {
                        isPresented = false
                    }
                )
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .frame(width: 264, height: 168)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct LuckyVickyAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alert: LuckyVickyAlertView
    
    func body(content: Content) -> some View {
        content
            .transparentFullScreenCover(
                isPresented: $isPresented
            ) {
                alert
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}
