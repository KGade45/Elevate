//
//  Post.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

class Post: Codable, Identifiable {
    let id: String
    let postedById: String?
    let caption: String?
    let imageUrl: String?
    let likes: [UserModel]?
    let comments: [Comment]?

    init(id: String, postedById: String, caption: String?, imageUrl: String?, likes: [UserModel]?, comments: [Comment]?) {
        self.id = id
        self.postedById = postedById
        self.caption = caption
        self.imageUrl = imageUrl
        self.likes = likes
        self.comments = comments
    }
}
