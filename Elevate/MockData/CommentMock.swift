//
//  CommentMock.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct CommentMock {
    static let comment1 = Comment(
        commentedBy: UserMock.emily,
        commentCaption: "This is so cool!"
    )

    static let comment2 = Comment(
        commentedBy: UserMock.mark,
        commentCaption: "Nice post!"
    )
}
