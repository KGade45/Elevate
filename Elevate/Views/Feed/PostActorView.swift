//
//  PostActorView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 24/09/25.
//

import SwiftUI

struct PostActorView: View {
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 25)
            Text("UserModel name")
                .padding(.leading, 10)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    PostActorView()
}
