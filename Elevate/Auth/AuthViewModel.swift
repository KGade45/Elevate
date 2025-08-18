//
//  AuthViewModel.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 12/08/25.
//

import Foundation
import Appwrite

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var currentUser: UserModel?
    @Published var isError: Bool = false
    
    private let client = Client()
        .setEndpoint("https://[YOUR-APPWRITE-ENDPOINT]/v1")
        .setProject("YOUR-APPWRITE-PROJECT-ID")
    
    // Services
    private var account: Account!
    private var databases: Databases!
    private var storage: Storage!

    init() {
        self.account = Account(client)
        self.databases = Databases(client)
        self.storage = Storage(client)
        
        Task {
            await loadCurrentUser()
        }
    }
    
    // Function to get the logged-in user and fetch their data
    func loadCurrentUser() async {
        do {
            let appwriteUser = try await account.get()
            await fetchUser(by: appwriteUser.id)
        } catch {
            print("No active session found or error fetching user: \(error.localizedDescription)")
            // No user session, nothing to do
        }
    }
    
    // Function to log a user in
    func login(email: String, password: String) async {
//        do {
//            let session = try await account.createEmailSession(email: email, password: password)
//            print("Session created for user: \(session.userId)")
//            await fetchUser(by: session.userId)
//        } catch {
//            isError = true
//            print("❌ Login Error: \(error.localizedDescription)")
//        }
    }
    
    // Function to fetch user data from the Appwrite database
    func fetchUser(by uid: String) async {
        let databaseId = "YOUR-DATABASE-ID"
        let collectionId = "YOUR-COLLECTION-ID"
        
        do {
            let document = try await databases.getDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: uid
            )
            // Convert the Appwrite document to your local UserModel model
//            self.currentUser = try JSONDecoder().decode(UserModel.self, from: document.data)
        } catch {
            isError = true
            print("❌ Error fetching user data: \(error.localizedDescription)")
        }
    }

    // Function to create a new user account with a profile picture
    func createUser(email: String, name: String, password: String, profileImageData: Data) async {
        let databaseId = "YOUR-DATABASE-ID"
        let usersCollectionId = "YOUR-USERS-COLLECTION-ID"
        let profileImageBucketId = "YOUR-PROFILE-IMAGE-BUCKET-ID"
        
        do {
            print("Creating user...")
            // 1. Create the user account in Appwrite
            let createdAccount = try await account.create(
                userId: ID.unique(),
                email: email,
                password: password,
                name: name
            )
            let uid = createdAccount.id
            print("UserModel created with UID: \(uid)")
            
            // 2. Upload the profile image to Appwrite Storage
            print("Uploading profile image...")
//            let appwriteFile = try await storage.createFile(
//                bucketId: profileImageBucketId,
//                fileId: ID.unique(),
//                file: InputFile.fromData(profileImageData, filename: "profile_pic.jpg", mimeType: <#String#>)
//            )
//            print("Upload successful! File ID: \(appwriteFile.id)")
            
            // 3. Construct the public URL for the image
//            let profilePhotoUrl = "https://[YOUR-APPWRITE-ENDPOINT]/v1/storage/buckets/\(profileImageBucketId)/files/\(appwriteFile.id)/view?project=YOUR-APPWRITE-PROJECT-ID"
//            print("Download URL: \(profilePhotoUrl)")
//            
//            // 4. Store user data in the Appwrite Database
//            storeUserInAppwrite(
//                id: uid,
//                email: email,
//                name: name,
//                profilePhotoUrl: URL(string: profilePhotoUrl)!
//            )
            
        } catch {
            isError = true
            print("❌ Appwrite Error: \(error.localizedDescription)")
        }
    }
    
    // Helper function to store user data in Appwrite
    func storeUserInAppwrite(id: String, email: String, name: String, profilePhotoUrl: URL) {
        let databaseId = "YOUR-DATABASE-ID"
        let collectionId = "YOUR-USERS-COLLECTION-ID"
        
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "profilePhotoUrl": profilePhotoUrl.absoluteString
        ]
        
        Task {
            do {
                try await databases.createDocument(
                    databaseId: databaseId,
                    collectionId: collectionId,
                    documentId: id,
                    data: userData
                )
                print("UserModel saved successfully.")
                // After saving, create a session and load the user
//                let _ = try await account.createEmailSession(email: email, password: password)
                await fetchUser(by: id)
            } catch {
                isError = true
                print("Error saving user: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to log a user out
    func signOut() {
        Task {
            do {
                try await account.deleteSessions()
                currentUser = nil
                print("UserModel signed out successfully.")
            } catch {
                isError = true
                print("❌ Sign Out Error: \(error.localizedDescription)")
            }
        }
    }
}

