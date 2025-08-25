//
//  AddPostView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 21/08/25.
//

import SwiftUI
import PhotosUI

struct AddPostView: View {
    @StateObject private var viewModel = PhotoPickerViewModel()
    @State private var caption: String = ""
    private let imageService = ImageService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Caption Input
                    TextField("What's on your mind?", text: $caption, axis: .vertical)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 80, alignment: .topLeading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .font(.system(size: 16))
                        .padding(.horizontal)
                    
                    // MARK: - Selected Image Preview
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .shadow(radius: 4)
                    }
                    
                    // MARK: - Add Image Button
                    PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                        HStack {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                            Text("Choose from Gallery")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.top)
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            await imageService.uploadImage(image: viewModel.selectedImage!) { url in
                                print("Error this is button")
                            }
                            print("Uploaded image this is button")
                        }
                    }
                    .font(.system(size: 16, weight: .semibold))
                }
            }
        }
    }
}

#Preview {
    AddPostView()
}
