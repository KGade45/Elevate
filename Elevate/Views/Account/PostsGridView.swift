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

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(PostMock.posts){ post in
                    PostTitleView(post: post)
                }
            }
        }
    }
}

struct PostsGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostsGridView()
    }
}
