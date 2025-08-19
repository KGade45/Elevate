//
//  Appwrite.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import Foundation
import Appwrite
import JSONCodable

@MainActor
class Appwrite: ObservableObject {
    var client: Client
    var account: Account
    @Published var currentUser: User<[String: AnyCodable]>?
    @Published var userSession: Session?
    @Published var isError: Bool = false

    public init() {
        self.client = Client()
            .setEndpoint(Constants.endPoint)
            .setProject(Constants.projectId)
        
        self.account = Account(client)
        Task {
            await self.loadSession()
        }
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
        userSession = try await account.createEmailPasswordSession(
            email: email,
            password: password
        )
        currentUser = try await account.get()
        return userSession!
    }

    public func onLogout() async throws {
        userSession = nil
        currentUser = nil
        _ = try await account.deleteSession(
            sessionId: "current"
        )
    }

    public func loadSession() async {
        do {
            currentUser = try await account.get()
            userSession = try await account.getSession(sessionId: "current")
        } catch {
            userSession = nil
        }
    }
}

