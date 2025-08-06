//
//  PostActionsView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct PostActionsView: View {
    
    @State var isLiked: Bool = false
    @State var shouldShowBottomsheet: Bool = false
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                isLiked = !isLiked
            }) {
                VStack(spacing: 4) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .renderingMode(.original)
                        .font(.system(size: 18))
                    Text("Like")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }

            Button(action: {
            
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "ellipsis.bubble")
                        .font(.system(size: 18))
                    Text("Comment")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }

            Button(action: {
                shouldShowBottomsheet = true
            }) {
                VStack(spacing: 4) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 18))
                    Text("Share")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
            }
            .sheet(isPresented: $shouldShowBottomsheet) {
                Text("TODO: Include user from Friend list")
                    .presentationDetents([.medium])
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .foregroundColor(.primary)
//        .border(.black)
    }
}


struct PostActionsView_Previews: PreviewProvider {
    static var previews: some View {
        PostActionsView()
    }
}
