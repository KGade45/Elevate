//
//  AccountMainView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct AccountMainView: View {

    @State private var selectedTab = 0
    var body: some View {
        VStack {
            AccountTopCardView()
                .padding(.bottom)
            VStack {
                Picker("Section", selection: $selectedTab) {
                    Label("Posts", systemImage: "square.grid.3x3")
                        .tag(0)
                    Label("Friends", systemImage: "person.2")
                        .tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Divider()
                Group {
                    switch selectedTab {
                    case 0:
                        PostsGridView()
                    case 1:
                        FriendsView()
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct AccountMainView_Previews: PreviewProvider {
    static var previews: some View {
        AccountMainView()
    }
}
