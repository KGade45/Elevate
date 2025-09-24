//
//  SinglePostView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct SinglePostView: View {
    var body: some View {
        ZStack {
            VStack {
                PostActorView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                PostImageView()
                PostActionsView()
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 12)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        
    }
}

struct SinglePostView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePostView()
    }
}
