//
//  ElevateApp.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI
import Appwrite

@main
struct ElevateApp: App {

    @ObservedObject private var router = Router()
    @StateObject var authViewModel = AuthViewModel()

    let appwriteClient = Client()
        .setEndpoint("https://[YOUR-APPWRITE-ENDPOINT]/v1")
        .setProject("YOUR-APPWRITE-PROJECT-ID")

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.AuthFlow.self) { destination in
                        switch destination {
                        case .loginwithEmail: MainTabView()
                        case .loginwithGoogle: MainTabView()
                        case .loginwithPhone: MainTabView()
                        case .signUp: MainTabView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(authViewModel)
        }
    }
}
