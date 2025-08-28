//
//  PostTitleView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct PostTitleView: View {

    var post: Post
    let imageService = ImageService()
    @State private var uiImage: UIImage? = nil

    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 130)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 130)
                    .overlay(
                        ProgressView()
                    )
            }
        }
        .task {
            await loadImage()
        }
        .padding()
    }
    
    private func loadImage() async {
        do {
            if let image = await imageService.getImage(fileId: post.imageId) {
                uiImage = image
            }
        }
    }
}
