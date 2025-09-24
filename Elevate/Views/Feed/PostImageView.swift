//
//  PostImageView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 24/09/25.
//

import SwiftUI

struct PostImageView: View {
    @State private var heartPosition: CGPoint?
    @State private var heartScale: CGFloat = 0.0
    @State private var heartRotation: Double = 0.0
    var body: some View {
        ZStack {
            Image("Nature")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 300)
                .onTapGesture(count: 2) { location in
                    // Initial bounce up with a slight rotation
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                        self.heartPosition = location
                        self.heartScale = 1.2
                        self.heartRotation = 15 // Rotate the heart
                    }
                    
                    // Small delay to make it pop before resetting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            self.heartRotation = 0
                        }
                    }
                    
                    // Fade out and disappear
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.heartScale = 0.0
                            self.heartPosition = nil
                        }
                    }
                }
            
            if let position = heartPosition {
                Heart()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.purple, Color.pink, Color.red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 40, height: 40)
                    .position(position)
                    .scaleEffect(heartScale)
                    .rotationEffect(.degrees(heartRotation))
            }
        }
    }
}

#Preview {
    PostImageView()
}
