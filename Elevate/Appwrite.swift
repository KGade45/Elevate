//
//  Appwrite.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import Foundation
import Appwrite
import JSONCodable

class Appwrite {
    var client: Client
    var account: Account

    public init() {
        self.client = Client()
            .setEndpoint("https://fra.cloud.appwrite.io/v1")
            .setProject("68a3378b0022d6172a6b")
        
        self.account = Account(client)
    }

    public func onRegister(
        _ email: String,
        _ password: String
    ) async throws -> User<[String: AnyCodable]> {
        try await account.create(
            userId: ID.unique(),
            email: email,
            password: password
        )
    }

    public func onLogin(
        _ email: String,
        _ password: String
    ) async throws -> Session {
        try await account.createEmailPasswordSession(
            email: email,
            password: password
        )
    }

    public func onLogout() async throws {
        _ = try await account.deleteSession(
            sessionId: "current"
        )
    }
}

