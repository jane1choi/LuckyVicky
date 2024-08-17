//
//  LuckyVickyAlertView.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/29/24.
//

import SwiftUI

enum AlertType {
    case basic
    case twoButton
}

struct LuckyVickyAlertView: View {
    @Binding var isPresented: Bool
    private let title: String?
    private let message: String
    private let type: AlertType
    private let aciton: (() -> Void)?
    
    init(
        type: AlertType = .basic,
        isPresented: Binding<Bool>,
        title: String? = .none,
        message: String,
        action: (() -> Void)? = .none
    ) {
        self.type = type
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.aciton = action
    }
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                switch type {
                case .basic:
                    makeBasicAlert(message: message)
                case .twoButton:
                    makeTwoButtonAlert(title: title ?? "",
                                       message: message, 
                                       confirmAction: aciton ?? {})
                }
            }
            .frame(width: 264, height: 168)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    @ViewBuilder private func makeBasicAlert(message: String) -> some View {
        Text(message)
            .foregroundStyle(.black)
            .font(.pretendardM(14))
            .lineSpacing(5)
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
    
    @ViewBuilder private func makeTwoButtonAlert(title: String, message: String, confirmAction: @escaping () -> Void) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(.black)
                .font(.pretendardSB(14))
                .padding(.top, 26)
            Text(message)
                .foregroundStyle(.black)
                .font(.pretendardM(12))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .padding(.top, 3)
        }

        Spacer()
        HStack {
            LuckyVickyButton(
                type: .cancel, 
                size: .popUp,
                title: "취소",
                isActive: true,
                action: {
                    isPresented = false
                }
            )
            
            LuckyVickyButton(
                size: .popUp,
                title: "확인",
                isActive: true,
                action: {
                    isPresented = false
                    confirmAction()
                }
            )
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
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
