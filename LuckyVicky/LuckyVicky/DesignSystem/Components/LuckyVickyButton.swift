//
//  LuckyVickyButton.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct LuckyVickyButton: View {
    private let type: ButtonType
    private let size: ButtonSize
    private let image: LuckyVickyImage?
    private let title: String
    private let isActive: Bool
    private let action: () -> Void
    
    init(
        type: ButtonType = .confirm,
        size: ButtonSize = .normal,
        image: LuckyVickyImage? = .none,
        title: String,
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.type = type
        self.size = size
        self.image = image
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            guard isActive else { return }
            action()
        }, label: {
            HStack(spacing: 8) {
                if let image {
                    Image(image)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .font(size.font)
            }
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
        })
        .buttonStyle(CommonButtonStyle(isActive: isActive, type: type))
    }
}

struct CommonButtonStyle: ButtonStyle {
    private let isActive: Bool
    private let type: ButtonType
    
    init(
        isActive: Bool,
        type: ButtonType
    ) {
        self.isActive = isActive
        self.type = type
    }
    
    func makeBody(configuration: Configuration) -> some View {
        var foregroundColor: Color {
            switch type {
            case .confirm:
                isActive ? .mainBlack : .white
            case .cancel:
                Color.white
            }
        }
        
        var backgroundColor: Color {
            switch type {
            case .confirm:
                isActive ? .mainGreen : .lightGreen
            case .cancel:
                Color(.gray2)
            }
        }
        
        configuration.label
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

enum ButtonType {
    case confirm
    case cancel
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
