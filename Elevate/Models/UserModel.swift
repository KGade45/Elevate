//
//  User.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

class User: Codable, Identifiable {
    let id: String
    let name: String
    let friends: [User]?
    let about: String
    let postsIds: [String]?

    init(id: String, name: String, friends: [User]?, about: String, postsIds: [String]?) {
        self.id = id
        self.name = name
        self.friends = friends
        self.about = about
        self.postsIds = postsIds
    }
}
