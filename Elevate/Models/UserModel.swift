//
//  UserModel.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct UserModel: Codable {
    let id: String
    var name: String
    var profilePhotoId: String?
    var friends: [String]?
    var about: String?
    var postsIds: [String]?
    var email: String
}
