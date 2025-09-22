//
//  PostsGridView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct PostsGridView: View {

    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    let postService = PostsService()
    @EnvironmentObject var authviewModel: Appwrite
    @State private var posts: [Post] = []
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(posts){ post in
                    PostTitleView(post: post)
                }
            }
            .onAppear {
                Task {
                    do {
                        posts = try await postService.getPost(userId: authviewModel.currentUser?.id ?? "")
                    } catch {
                        print("Failed to fetch posts: \(error)")
                    }
                }
            }
        }
    }
}
