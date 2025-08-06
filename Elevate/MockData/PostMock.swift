//
//  PostMock.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct PostMock {
    static let post1 = Post(
        id: "post1",
        postedById: "u1",
        caption: "Check out this view!",
        imageUrl: "https://picsum.photos/300/200",
        likes: [UserMock.jane, UserMock.emily],
        comments: [CommentMock.comment1, CommentMock.comment2]
    )
}
