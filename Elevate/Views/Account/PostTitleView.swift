//
//  PostTitleView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct PostTitleView: View {

    var post: Posts
    var body: some View {
        VStack {
            Image("Nature")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 130)
                .clipped()
        }
        .padding()
    }
}

struct PostTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PostTitleView(post: PostMock.post)
    }
}
