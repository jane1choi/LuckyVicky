//
//  Font+.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/22/24.
//

import SwiftUI

extension Font {
    
    static func pretendardR(_ size: CGFloat) -> Font {
        return Font.custom("Pretendard-Regular", size: size)
    }
    
    static func pretendardM(_ size: CGFloat) -> Font {
        return Font.custom("Pretendard-Medium", size: size)
    }
    
    static func pretendardSB(_ size: CGFloat) -> Font {
        return Font.custom("Pretendard-SemiBold", size: size)
    }
}
