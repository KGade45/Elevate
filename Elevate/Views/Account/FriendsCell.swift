//
//  FriendsCell.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI
@MainActor
class FriendsCellModel: ObservableObject {
    @Published var name: String?
    @Published var profilePhoto: UIImage?
    let userId: String
    init(userId: String) {
        self.userId = userId
    }

    private var imageService = ImageService()
    private var userService = UserService()

    func loadUser() async {
        do {
            if let user = try await userService.getUser(userId: userId) {
                self.name = user.name
                if let fileId = user.profilePhotoId {
                    self.profilePhoto = await imageService.getImage(fileId: fileId)
                }
            }
        } catch {
            print("Failed to fetch user data: \(error.localizedDescription)")
        }
    }
}

struct FriendsCell: View {
    var userId: String
    @StateObject private var viewModel: FriendsCellModel
    init(userId: String) {
        self.userId = userId
        _viewModel = StateObject(wrappedValue: FriendsCellModel(userId: userId))
    }
    
    var body: some View {
            HStack(spacing: 20) {
                if let profilePhoto = viewModel.profilePhoto {
                    Image(uiImage: profilePhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    if let userName = viewModel.name {
                        Text(userName)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    Text("Tap to view Profile")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer()
            }
            .task {
                await viewModel.loadUser()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Divider()
        }
}
