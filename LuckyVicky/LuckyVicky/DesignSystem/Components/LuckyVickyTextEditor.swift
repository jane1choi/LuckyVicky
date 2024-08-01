//
//  LuckyVickyTextEditor.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct LuckyVickyTextEditor: View {
    @Binding private var text: String
    private let placeholder: String
    private let maxCharacterCount: Int
    
    init(
        text: Binding<String>,
        placeholder: String,
        maxCharacterCount: Int
    ) {
        self._text = text
        self.placeholder = placeholder
        self.maxCharacterCount = maxCharacterCount
    }
    
    var body: some View {
        TextEditor(text: $text)
            .autocorrectionDisabled(true)
            .font(.pretendardM(14))
            .foregroundStyle(Color(.mainBlack))
            .padding(.horizontal, 22)
            .padding(.vertical, 25)
            .lineSpacing(10)
            .background(Color(.white))
            .overlay(alignment: .topLeading) {
                if text.isEmpty {
                    TextEditor(text: .constant(placeholder))
                        .disabled(true)
                        .font(.pretendardM(14))
                        .foregroundStyle(Color(.gray1))
                        .padding(.horizontal, 22)
                        .padding(.vertical, 25)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .onChange(of: text) { newValue in
                if newValue.count > maxCharacterCount {
                    text = String(newValue.prefix(maxCharacterCount))
                }
            }
    }
}
