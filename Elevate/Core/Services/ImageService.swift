//
//  ImageService.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 25/08/25.
//

import Foundation
import Appwrite
import SwiftUI

public class ImageService {
    var client: Client
    var storage: Storage

    init() {
        self.client = Client()
            .setEndpoint(Constants.endPoint)
            .setProject(Constants.projectId)
        
        self.storage = Storage(client)
    }

    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) async {

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        do {
            let file = try await storage.createFile(
                bucketId: Constants.storageBucketId,
                fileId: ID.unique(),
                file: InputFile.fromData(imageData, filename: "post.jpg", mimeType: "image/jpeg")
            )
            print("File uploaded: \(file)")
        } catch {
            print("Upload failed: \(error.localizedDescription)")
        }
    }
}
