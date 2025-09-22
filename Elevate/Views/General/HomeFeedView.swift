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
                    _ = try await followerService.getFollowing()
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
