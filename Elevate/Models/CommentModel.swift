//
//  CommentModel.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

class Comments: Codable, Identifiable {
    let commentedBy: UserModel
    let commentCaption: String

    init(commentedBy: UserModel, commentCaption: String) {
        self.commentedBy = commentedBy
        self.commentCaption = commentCaption
    }
}

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    let postId: String
    let userId: String
    let content: String
    let createdAt: Date
}
