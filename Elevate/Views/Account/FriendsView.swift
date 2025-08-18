//
//  FriendsView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        ScrollView {
            VStack {
                FriendsCell()
                FriendsCell()
                FriendsCell()
                FriendsCell()
                FriendsCell()
                FriendsCell()
                FriendsCell()
                FriendsCell()
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
