//
//  UserModel.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct UserModel: Codable {
    let uid: String
    var name: String
    var profilePhotoId: String?
    var friends: [String]?
    var about: String?
    var postsIds: [String]?
    var email: String

    init(id: String = "u100", name: String = "", profilePhotoId: String? = nil, friends: [String]? = nil, about: String? = nil, postsIds: [String]? = nil, email: String = "") {
        self.uid = id
        self.name = name
        self.friends = friends
        self.about = about
        self.postsIds = postsIds
        self.email = email
    }
}
