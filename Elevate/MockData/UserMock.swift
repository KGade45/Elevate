//
//  UserMock.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct UserMock {
    static let jane = User(
        id: "u2",
        name: "Jane Smith",
        friends: nil,
        about: "Traveler 🌍",
        postsIds: nil
    )

    static let emily = User(
        id: "u3",
        name: "Emily Johnson",
        friends: nil,
        about: "Designer & artist.",
        postsIds: nil
    )

    static let mark = User(
        id: "u4",
        name: "Mark Lee",
        friends: nil,
        about: "Coffee lover ☕️",
        postsIds: nil
    )

    static let john = User(
        id: "u1",
        name: "John Doe",
        friends: [jane, emily],
        about: "iOS Developer from SF.",
        postsIds: ["post1"]
    )
}
