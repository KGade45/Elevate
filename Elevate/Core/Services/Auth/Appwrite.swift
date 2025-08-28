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
        self.client = AppwriteClient.shared.client
        self.account = Account(client)
        Task {
            await self.loadSession()
        }
    }

    public func onRegister(
        _ email: String,
        _ password: String,
        _ name: String
    ) async throws -> User<[String: AnyCodable]> {
        _ = try await account.create(
            userId: ID.unique(),
            email: email,
            password: password,
            name: name
        )
        userSession = try await account.createEmailPasswordSession(
            email: email,
            password: password
        )
        currentUser = try await account.get()
        return currentUser!
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

    public func updateUserInfo(userPrefs: [String: Any]) async {
        do {
            // 1. Fetch current user
            let currentUser = try await account.get()
            // 2. Get existing prefs
            let currentPrefs = currentUser.prefs.data

            var newPrefs: [String: Any] = [:]
            for (key, value) in currentPrefs {
                newPrefs[key] = value.value
            }

            // 3. Merge current and new preferences
            newPrefs = newPrefs.merging(userPrefs) { (current, _) in current }

            // 4. Update preferences
            _ = try await account.updatePrefs(
                prefs: newPrefs
            )
            // 5. Refresh user info
            self.currentUser = try await account.get()
        } catch {
            isError = true
            print("Error updating user info: \(error)")
        }
    }

    public func getUserInfo() async -> [String: Any]? {
        do {
            let prefs = try await account.getPrefs()
            return prefs.data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

