//
//  AppwriteClient.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 26/08/25.
//

import Appwrite
import Foundation
import SwiftUI

final class AppwriteClient {
    static let shared = AppwriteClient()

    let client: Client

    private init() {
        self.client = Client()
            .setEndpoint(Constants.endPoint)
            .setProject(Constants.projectId)
    }
}
