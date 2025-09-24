//
//  HomeFeedView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct HomeFeedView: View {
    var followerService = FollowersService()
    private let authViewModel = Appwrite()
    private let postService = PostsService()

    var body: some View {
        ZStack{
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            ScrollView {
                SinglePostView()
                SinglePostView()
                SinglePostView()
                SinglePostView()
            }
        }
        .onAppear {
            Task {
                do {
                    let users = try await followerService.getFollowing()
                    let posts = try await postService.getPost(userId: users.first?.id ?? "")
                    print(posts)
                } catch {
                    print("Failed to fetch posts: \(error)")
                }
            }
            
        }
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView()
    }
}
