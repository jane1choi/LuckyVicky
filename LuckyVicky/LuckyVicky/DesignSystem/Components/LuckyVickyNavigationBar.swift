//
//  LuckyVickyNavigationBar.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/26/24.
//

import SwiftUI

struct LuckyVickyNavigationBar: View {
    private let leftItem: (LuckyVickyImage, () -> Void)?
    private let rightItemList: [(LuckyVickyImage, () -> Void)]?
    
    init(
        leftItem: (LuckyVickyImage, () -> Void)? = .none,
        rightItemList: [(LuckyVickyImage, () -> Void)]?  = .none
    ) {
        self.leftItem = leftItem
        self.rightItemList = rightItemList
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if let leftItem {
                Button(action: {
                    leftItem.1()
                }, label: {
                    Image(leftItem.0)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                })
            }
            Spacer()
            if let rightItemList {
                HStack(spacing: 0) {
                    ForEach(rightItemList, id: \.0) { item in
                        Button(action: {
                            item.1()
                        }, label: {
                            Image(item.0)
                                .resizable()
                                .frame(width: 44, height: 44)
                        })
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
        .frame(maxWidth: .infinity)
    }
}
