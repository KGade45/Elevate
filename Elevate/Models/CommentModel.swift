//
//  CommentModel.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

class Comment: Codable, Identifiable {
    let commentedBy: User
    let commentCaption: String

    init(commentedBy: User, commentCaption: String) {
        self.commentedBy = commentedBy
        self.commentCaption = commentCaption
    }
}
