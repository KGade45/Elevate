//
//  Posts.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

class Posts: Codable, Identifiable {
    let id: String
    let postedById: String?
    let caption: String?
    let imageUrl: String?
    let likes: [UserModel]?
    let comments: [Comments]?

    init(id: String, postedById: String, caption: String?, imageUrl: String?, likes: [UserModel]?, comments: [Comments]?) {
        self.id = id
        self.postedById = postedById
        self.caption = caption
        self.imageUrl = imageUrl
        self.likes = likes
        self.comments = comments
    }
}

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let userId: String
    let caption: String?
    let imageUrl: String?
    var likes: [String]
    let createdAt: Date
}
