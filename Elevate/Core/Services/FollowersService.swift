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

    func getFollowing() async throws -> [UserModel] {
            var followings: [UserModel] = []

            do {
                // Step 1: Fetch ALL documents from the follow collection without a query.
                // This is confirmed to work based on your previous debugging.
                let followDocuments = try await database.listDocuments(
                    databaseId: Constants.databaseId,
                    collectionId: Constants.followCollectionId
                )
                
                // Step 2: Manually filter the documents on the client side.
                // This bypasses the problematic Query.equal.
                let filteredFollows = followDocuments.documents.filter { doc in
                    if let followerIdFromDB = doc.data["followerId"]?.value as? String {
                        return followerIdFromDB == authViewModel.currentUser?.id ?? ""
                    }
                    return false
                }
                
                // Step 3: Iterate through the now-filtered documents.
                for document in filteredFollows {
                    if let followingId = document.data["followingId"]?.value as? String {
                        let userDoc = try await database.getDocument(
                            databaseId: Constants.databaseId,
                            collectionId: "user",
                            documentId: followingId
                        )
                        
                        var userDocData = userDoc.data
                        
                        // Corrected line: Assign the ID directly to the key.
                        // The SDK automatically handles the AnyCodable wrapper.
                        userDocData["$id"] = AnyCodable(userDoc.id)
                        
                        var cleanedData: [String: Any] = [:]
                        for (key, value) in userDocData {
                            cleanedData[key] = value.value
                        }
                        
                        // Now, convert the cleaned dictionary to Data
                        let jsonData = try JSONSerialization.data(withJSONObject: cleanedData, options: [])
                        
                        // Finally, decode the Data into your model
                        let user = try JSONDecoder().decode(UserModel.self, from: jsonData)
                        followings.append(user)
                    }
                }
                return followings
            } catch {
                print("Error fetching followings: \(error.localizedDescription)")
                throw error // Re-throw the error for the ViewModel to handle.
            }
        }

    func debugFollowerID() async {
        // This is a temporary function for debugging purposes only
        guard let currentUserId = authViewModel.currentUser?.id else {
            print("User is not authenticated.")
            return
        }
        
        // Replace with a known document ID from your Appwrite database
        let knownDocumentId = "68d17e5e03733fe59f27"
        
        do {
            let document = try await database.getDocument(
                databaseId: Constants.databaseId,
                collectionId: Constants.followCollectionId,
                documentId: knownDocumentId
            )
            
            // Extract the followerId from the retrieved document
            if let followerIdFromDB = document.data["followerId"]?.value as? String {
                print("--- String Comparison Debug ---")
                print("1. User ID (from app): '\(currentUserId)'")
                print("2. DB ID (from fetched doc): '\(followerIdFromDB)'")
                
                if currentUserId == followerIdFromDB {
                    print("Result: IDs are an EXACT match. The Query.equal call should have worked.")
                } else {
                    print("Result: IDs DO NOT match. There is a hidden difference.")
                    print("Length of User ID: \(currentUserId.count)")
                    print("Length of DB ID: \(followerIdFromDB.count)")
                }
                print("------------------------------")
            } else {
                print("Error: Could not find 'followerId' in the document or it's not a String.")
            }
        } catch {
            print("Error fetching known document: \(error)")
        }
    }
}
