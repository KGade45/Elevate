//
//  PostMock.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import Foundation

struct PostMock {
    static let post = Post(
        id: "post1",
        postedById: "u1",
        caption: "Check out this view!",
        imageUrl: "https://picsum.photos/300/200",
        likes: [UserMock.jane, UserMock.emily],
        comments: [CommentMock.comment1, CommentMock.comment2]
    )
    static let posts: [Post] = {
        var allPosts: [Post] = []
        let captions = [
            "Exploring the mountains 🏔",
            "Sunset vibes 🌅",
            "Morning run completed ✅",
            "Café hopping ☕️",
            "Weekend getaway 🚗",
            "My favorite trail 🌲",
            "Beach day 🏖",
            "City lights ✨",
            "Nature walk 🌳",
            "Golden hour magic ✨",
            "Snow adventure ❄️",
            "Hiking with friends 🥾",
            "Peaceful lake morning 🌊",
            "Fresh air feels 💨",
            "Late night thoughts 🌙",
            "Hello from the top! 📸",
            "Views worth the climb ⛰",
            "Ocean breeze 🌬",
            "Chasing clouds ☁️",
            "New beginnings 🌱"
        ]

        for i in 1...20 {
            let post = Post(
                id: "post\(i)",
                postedById: "u1",
                caption: captions.randomElement(),
                imageUrl: "https://picsum.photos/id/\(100 + i)/300/200",
                likes: [UserMock.jane, UserMock.emily],
                comments: [CommentMock.comment1, CommentMock.comment2]
            )
            allPosts.append(post)
        }

        return allPosts
    }()
}
