//
//  UserModel.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

//struct UserModel: Codable {
//    let id: String
//    var name: String
//    var profilePhotoId: String?
//    var about: String?
//    var email: String
//
//    init(id: String, name: String, profilePhotoId: String? = nil, about: String? = nil, email: String) {
//        self.id = id
//        self.name = name
//        self.profilePhotoId = profilePhotoId
//        self.about = about
//        self.email = email
//    }
//}

struct UserModel: Codable, Identifiable {
    let id: String
    var name: String
    var profilePhotoId: String?
    var about: String?
    var email: String
    
    // Add CodingKeys to map Appwrite's field names to your struct properties
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case name
        case profilePhotoId
        case about
        case email
    }
}
