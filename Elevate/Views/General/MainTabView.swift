//
//  MainTabView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var searchUser: String = ""
    @EnvironmentObject var router: Router
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()

            TabView {
                HomeFeedView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Feed")
                    }

                MyNetworkView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("My Network")
                    }

                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell")
                        Text("Notifications")
                    }

                AccountView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
                    .environmentObject(authViewModel)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    TextField("Search user", text: $searchUser)
                        .padding(5)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                    
                    Button(action: {
                        print("Messages tapped")
                    }) {
                        Image(systemName: "paperplane")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
