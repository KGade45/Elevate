//
//  UserService.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 12/09/25.
//

import Appwrite
import JSONCodable
import SwiftUI

public class UserService {
    var client: Client
    var database: Databases
    var imageService: ImageService
    init() {
        self.client = AppwriteClient.shared.client
        self.database = Databases(client)
        self.imageService = ImageService()
    }

    func createUser(id: String, name: String, email: String, image: UIImage?) async throws {
        var imageId: String?

        if let image = image {
            imageId = await imageService.uploadImage(image: image)
        }

        do {
            _ = try await database.createDocument(
                databaseId: Constants.databaseId,
                collectionId: "user",
                documentId: id,
                data: [
                    "name": name,
                    "email": email,
                    "profilePhotoId": imageId ?? ""
                ]
            )
        } catch {
            print("Error creating post: \(error.localizedDescription)")
        }
    }

    func getUser(userId: String) async throws -> UserModel? {
        do {
            let documentList = try await database.listDocuments(
                databaseId: Constants.databaseId,
                collectionId: "user",
                queries: [Query.equal("$id", value: userId)]
            )

            // Get the first document from the list
            guard let document = documentList.documents.first else {
                return nil
            }

            // Convert the AnyCodable dictionary to a standard dictionary
            var unwrappedData: [String: Any] = [:]
            for (key, value) in document.data {
                if let anyCodableValue = value as? AnyCodable {
                    unwrappedData[key] = anyCodableValue.value
                } else {
                    unwrappedData[key] = value
                }
            }

            // Re-serialize the data into JSON Data
            let jsonData = try JSONSerialization.data(withJSONObject: unwrappedData)

            // Decode the JSON Data into your UserModel
            let userModel = try JSONDecoder().decode(UserModel.self, from: jsonData)
            return userModel
        } catch {
            print("Error getting User: \(error.localizedDescription)")
            throw error
        }
    }
}
