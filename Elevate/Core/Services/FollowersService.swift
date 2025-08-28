//
//  FollowersService.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 28/08/25.
//

import Appwrite
import Foundation
import JSONCodable

@MainActor
class FollowersService {
    var authViewModel = Appwrite()
    var client: Client
    var database: Databases
    init() {
        self.client = AppwriteClient.shared.client
        self.database = Databases(client)

    }

    func createConnection() async throws {
        do {
            let _ = try await database.createDocument(
                databaseId: Constants.databaseId,
                collectionId: Constants.followCollectionId,
                documentId: ID.unique(),
                data: Connection()
            )
        } catch {
            print("Error making: \(error.localizedDescription)")
        }
    }

    func getFollowing() async throws {
        var followings: [UserModel] = []
        do {
            let documents = try await database.listDocuments(
                databaseId: Constants.databaseId,
                collectionId: Constants.followCollectionId,
                queries: [Query.equal("followerId", value: authViewModel.currentUser?.id ?? "")]
            )
            for document in documents.documents {
                let followId = document.data["followingId"]?.value as? String
                
                // TODO: - create a users table tobe able to fetch all the users
            }
            print(followings)
        } catch {
            print("Error fetching posts: \(error.localizedDescription)")
        }
    }
}
