//
//  LuckyVickyTextEditor.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/23/24.
//

import SwiftUI

struct LuckyVickyTextEditor: View {
    @Binding var text: String
    let placeholder: String
    
    init(
        text: Binding<String>,
        placeholder: String
    ) {
        self._text = text
        self.placeholder = placeholder
    }
    
    var body: some View {
        TextEditor(text: $text)
            .keyboardType(.alphabet)
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
    }
}
