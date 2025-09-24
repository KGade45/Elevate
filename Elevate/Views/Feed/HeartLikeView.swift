//
//  HeartLikeView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 24/09/25.
//

import SwiftUI

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from the bottom tip of the heart
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        // Left side curve
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.height/4),
                      control1: CGPoint(x: rect.midX, y: rect.height * 3/4),
                      control2: CGPoint(x: rect.minX, y: rect.height/2))
        
        // Top left arc
        path.addArc(center: CGPoint(x: rect.width/4, y: rect.height/4),
                    radius: rect.width/4,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)
        
        // Top right arc
        path.addArc(center: CGPoint(x: rect.width * 3/4, y: rect.height/4),
                    radius: rect.width/4,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)
        
        // Right side curve
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX, y: rect.height/2),
                      control2: CGPoint(x: rect.midX, y: rect.height * 3/4))
        
        return path
    }
}

