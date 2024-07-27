//
//  LuckyVickyChatBubble.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/27/24.
//

import SwiftUI

enum TailDirection {
    case left
    case right
}

struct LuckyVickyChatBubble: Shape {
    private let cornerRadius: CGFloat
    private let direction: TailDirection
    
    init(
        cornerRadius: CGFloat,
        direction: TailDirection
    ) {
        self.cornerRadius = cornerRadius
        self.direction = direction
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        var tail = Path()
        
        switch direction {
        case .left:
            path.addPath(roundedRect.path(in: CGRect(x: rect.minX + 19,
                                                     y: rect.minY,
                                                     width: rect.width - 19,
                                                     height: rect.height)))
            tail.move(to: CGPoint(x: rect.minX, y: rect.minY + 7))
            tail.addLine(to: CGPoint(x: rect.minX + 22, y: rect.minY + 11))
            tail.addLine(to: CGPoint(x: rect.minX + 22, y: rect.minY + 30))
            tail.closeSubpath()
        case .right:
            path.addPath(roundedRect.path(in: CGRect(x: rect.minX, 
                                                     y: rect.minY,
                                                     width: rect.width - 19,
                                                     height: rect.height)))
            tail.move(to: CGPoint(x: rect.maxX - 22, y: rect.minY + 11))
            tail.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 7))
            tail.addLine(to: CGPoint(x: rect.maxX - 22, y: rect.minY + 30))
            tail.closeSubpath()
        }
        
        path.addPath(tail)
        
        return path
    }
}
