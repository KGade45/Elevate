//
//  PostsService.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 26/08/25.
//

import Appwrite
import Foundation
import SwiftUI
import JSONCodable
public class PostsService {
    var client: Client
    var database: Databases
    var imageService: ImageService
    init() {
        self.client = AppwriteClient.shared.client
        self.database = Databases(client)
        self.imageService = ImageService()
    }

    func createPost(userId: String, caption: String, image: UIImage?) async throws {
        let imageId: String?

        if let image = image {
            imageId = await imageService.uploadImage(image: image)
        } else {
            print("No image provided")
            return
        }

        let dateFormatter = ISO8601DateFormatter()
        let now = dateFormatter.string(from: Date())
        let newPost = NewPost(userId: userId, caption: caption, createdAt: now, imageId: imageId)

        do {
            let _ = try await database.createDocument(
                databaseId: Constants.databaseId,
                collectionId: Constants.postCollectionId,
                documentId: ID.unique(),
                data: newPost
            )
        } catch {
            print("Error creating post: \(error.localizedDescription)")
        }
    }

    func getPost(userId: String) async throws -> [Post] {
        var posts: [Post] = []

        do {
            let documentList = try await database.listDocuments(
                databaseId: Constants.databaseId,
                collectionId: Constants.postCollectionId,
                queries: [Query.equal("userId", value: userId)]
            )
            
            for document in documentList.documents {
                // Create a dictionary to unwraps the AnyCodable values
                var unwrappedData: [String: Any] = [:]
                for (key, value) in document.data {
                    if let anyCodableValue = value as? AnyCodable {
                        unwrappedData[key] = anyCodableValue.value
                    } else {
                        unwrappedData[key] = value
                    }
                }

                let jsonData = try JSONSerialization.data(withJSONObject: unwrappedData)
                let post = try JSONDecoder().decode(Post.self, from: jsonData)
                posts.append(post)
            }
        } catch {
            print("Error getting posts: \(error.localizedDescription)")
            throw error
        }

        return posts
    }
}

struct Connection: Codable {
    let followerId: String
    let followingId: String

    init() {
        self.followerId = "68d17009af5888d8e86d"
        self.followingId = "68d17dc8659a780929e6"
    }
}
struct NewPost: Codable {
    let userId: String
    let caption: String
    let likesCount: Int
    let commentsCount: Int
    let createdAt: String
    let imageId: String?

    init(userId: String, caption: String, createdAt: String, imageId: String?) {
        self.userId = userId
        self.caption = caption
        self.createdAt = createdAt
        self.imageId = imageId
        self.likesCount = 0
        self.commentsCount = 0
    }
}

