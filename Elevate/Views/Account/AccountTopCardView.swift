//
//  AccountView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI
import JSONCodable

// 1. Create a ViewModel to handle the async logic
@MainActor
class AccountViewModel: ObservableObject {
    @Published var bio: String = ""
    @Published var profilePhoto: UIImage?
    @Published var isFollowing: Bool = false
    
    private var imageService = ImageService()
    private var userService = UserService()
    private var followService = FollowersService()
    
    // Function to fetch user data
    func fetchUserData(for userId: String) async {
        do {
            if let user = try await userService.getUser(userId: userId) {
                // Update properties on the main actor
                self.bio = user.about ?? ""
                
                if let fileId = user.profilePhotoId {
                    self.profilePhoto = await imageService.getImage(fileId: fileId)
                }
            }
        } catch {
            print("Failed to fetch user data: \(error.localizedDescription)")
        }
    }
    
    // Function to handle the follow/unfollow action
    func createFollowConnection() async {
        do {
            try await followService.createConnection()
            // Update the UI after a successful action
            self.isFollowing.toggle()
        } catch {
            print("Failed to create follow connection: \(error.localizedDescription)")
        }
    }
}

struct AccountTopCardView: View {
    @StateObject private var viewModel = AccountViewModel()
    @EnvironmentObject var authViewModel: Appwrite
    
    @State private var isSelf: Bool = true
    @GestureState private var isPressing = false
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.1)
            .updating($isPressing) { currentState, gestureState, _ in
                gestureState = currentState
            }
        
        VStack {
            HStack(alignment: .center, spacing: 16) {
                Group {
                    if let profilePhoto = viewModel.profilePhoto {
                        Image(uiImage: profilePhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.gray.opacity(0.6))
                    }
                }
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                .scaleEffect(isPressing ? 1.5 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isPressing)
                .gesture(longPressGesture)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(authViewModel.currentUser?.name ?? "User")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(viewModel.bio)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .task {
                    // Start the async operation when the view appears
                    if let userId = authViewModel.currentUser?.id {
                        await viewModel.fetchUserData(for: userId)
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            
            HStack {
                Button {
                    Task {
                        await viewModel.createFollowConnection()
                    }
                } label: {
                    Text(isSelf ? "Edit Profile" : "Follow")
                        .font(.body)
                        .foregroundStyle(Color(.systemBlue))
                        .padding(.horizontal, 150)
                        .padding(.vertical, 5)
                        .overlay(
                            Capsule()
                                .stroke(Color(.systemBlue), lineWidth: 1)
                        )
                }
            }
        }
    }
}


struct AccountTopCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTopCardView()
    }
}
