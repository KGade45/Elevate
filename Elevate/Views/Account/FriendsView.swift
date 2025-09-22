//
//  FriendsView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

@MainActor
class FriendsViewModel: ObservableObject {
    @Published var friends: [UserModel] = []

    private var followService = FollowersService()
    private var authViewModel = Appwrite()

    func getFriends() async {
        do {
            self.friends = try await followService.getFollowing()
        } catch {
            print("Error fetching friends: \(error)")
        }
    }
}

struct FriendsView: View {
    @StateObject private var viewModel = FriendsViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                if viewModel.friends.isEmpty {
                    ProgressView()
                        .padding(.top)
                } else {
                    ForEach(viewModel.friends) { friend in
                        FriendsCell(userId: friend.id)
                            .padding(.horizontal)
                    }
                }
            }
            .task {
                await viewModel.getFriends()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
