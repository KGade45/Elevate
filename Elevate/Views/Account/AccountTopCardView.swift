//
//  AccountView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI
import JSONCodable

struct AccountTopCardView: View {
    @State private var isSelf: Bool = true
    @GestureState private var isPressing = false
    @EnvironmentObject var authViewModel: Appwrite
    @State private var bio: String = ""
    @State private var profilePhoto: UIImage?
    private var imageService = ImageService()
    let followService = FollowersService()
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.1)
            .updating($isPressing) { currentState, gestureState, _ in
                gestureState = currentState
            }
        VStack {
            HStack(alignment: .center, spacing: 16) {
                Group {
                    if let profilePhoto {
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
                    
                    Text(bio)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .task {
                    if let prefs = await authViewModel.getUserInfo() {
                        // Bio
                        if let bioValue = prefs["bio"] as? AnyCodable,
                           let bioString = bioValue.value as? String {
                            bio = bioString
                        }

                        // Profile Photo
                        if let fileIdValue = prefs["profilePhoto"] as? AnyCodable,
                           let fileId = fileIdValue.value as? String {
                            if let image = await imageService.getImage(fileId: fileId) {
                                profilePhoto = image
                            }
                        }
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
                        try await followService.createConnection()
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
