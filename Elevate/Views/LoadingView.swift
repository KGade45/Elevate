//
//  LoadingView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
