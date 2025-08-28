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
        self.client = AppwriteClient.shared.client
        self.storage = Storage(client)
    }

    func uploadImage(image: UIImage) async -> String? {

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }

        do {
            let file = try await storage.createFile(
                bucketId: Constants.storageBucketId,
                fileId: ID.unique(),
                file: InputFile.fromData(imageData, filename: "post.jpg", mimeType: "image/jpeg")
            )
            return file.id
        } catch {
            print("Upload failed: \(error.localizedDescription)")
            return nil
        }
    }

    func getImage(fileId: String) async -> UIImage? {
        do {
            let byteBuffer = try await storage.getFileDownload(
                bucketId: Constants.storageBucketId,
                fileId: fileId
            )

            // Convert ByteBuffer → Data
            var buffer = byteBuffer
            if let bytes = buffer.readBytes(length: buffer.readableBytes) {
                let data = Data(bytes)
                return UIImage(data: data)
            }
        } catch {
            print("Error loading image:", error.localizedDescription)
        }
        return nil
    }

}
