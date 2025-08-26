//
//  PostsService.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 26/08/25.
//

import Appwrite
import Foundation
import SwiftUI

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
}

struct NewPost {
    let userId: String
    let caption: String
    let likesCount: Int = 0
    let commentsCount: Int = 0
    let createdAt: String
    let imageId: String?
}
