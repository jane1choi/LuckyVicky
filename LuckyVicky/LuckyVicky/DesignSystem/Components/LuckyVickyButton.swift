//
//  LuckyVickyButton.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct LuckyVickyButton: View {
    private let title: String
    private let isActive: Bool
    private let action: () -> Void
    
    init(
        title: String,
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
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
                .font(.pretendardSB(18))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
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
