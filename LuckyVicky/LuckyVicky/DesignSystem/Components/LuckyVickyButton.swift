//
//  LuckyVickyButton.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct LuckyVickyButton: View {
    private let size: ButtonSize
    private let title: String
    private let isActive: Bool
    private let action: () -> Void
    
    init(
        size: ButtonSize = .normal,
        title: String,
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.size = size
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            guard isActive else { return }
            action()
        }, label: {
            Text(title)
                .font(size.font)
                .frame(maxWidth: .infinity)
                .frame(height: size.height)
        })
        .buttonStyle(CommonButtonStyle(isActive: isActive))
    }
}

struct CommonButtonStyle: ButtonStyle {
    private let isActive: Bool
    
    init(
        isActive: Bool
    ) {
        self.isActive = isActive
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(isActive ? .mainBlack : .white)
            .background(isActive ? .mainGreen : .lightGreen)
            .cornerRadius(10)
    }
}

enum ButtonSize {
    case normal
    case popUp
    
    var font: Font {
        switch self {
        case .normal:
            return .pretendardSB(18)
        case .popUp:
            return .pretendardSB(15)
        }
    }
    
    var height: CGFloat {
        switch self {
        case .normal:
            return 52
        case .popUp:
            return 48
        }
    }
}
