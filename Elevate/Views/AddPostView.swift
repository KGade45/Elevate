//
//  AddPostView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 21/08/25.
//

import SwiftUI
import PhotosUI

@MainActor
class AddPostViewModel: ObservableObject {
    @Published var caption: String = ""
    @Published var isLoading: Bool = false
    
    private var postService = PostsService()
    
    func createPost(userId: String, image: UIImage?) async throws {
        isLoading = true
        defer { isLoading = false }

        do {
            try await postService.createPost(userId: userId, caption: caption, image: image)
            caption = ""
        } catch {
            print("Error creating post: \(error.localizedDescription)")
            throw error
        }
    }
}

struct AddPostView: View {
    @StateObject private var photoPickerViewModel = PhotoPickerViewModel()
    @StateObject private var viewModel = AddPostViewModel()
    
    @EnvironmentObject var authViewModel: Appwrite
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Caption Input
                    TextField("What's on your mind?", text: $viewModel.caption, axis: .vertical)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 80, alignment: .topLeading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .font(.system(size: 16))
                        .padding(.horizontal)
                    
                    // MARK: - Selected Image Preview
                    if let image = photoPickerViewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .shadow(radius: 4)
                    }
                    
                    // MARK: - Add Image Button
                    PhotosPicker(selection: $photoPickerViewModel.imageSelection, matching: .images) {
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            guard let userId = authViewModel.currentUser?.id else { return }
                            do {
                                try await viewModel.createPost(userId: userId, image: photoPickerViewModel.selectedImage)
                                dismiss()
                            } catch {}
                        }
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .opacity(viewModel.isLoading ? 0.5 : 1.0)
                    .disabled(viewModel.isLoading)
                }
            }
        }
    }
}

#Preview {
    AddPostView()
}
