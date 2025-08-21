//
//  SingleNotificationView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 21/08/25.
//

import SwiftUI

struct SingleNotificationView: View {
    @State var followNotification: Bool = false
    @State var likeNotification: Bool = true
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            // Profile Image
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
            
            // Text
            VStack(alignment: .leading, spacing: 4) {
                Text("ABCD")
                    .font(.headline)
                
                if likeNotification {
                    Text("Liked your post")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else if followNotification {
                    Text("Followed you")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .lineLimit(1)
            
            Spacer()
            
            // Right-side content (photo preview or button)
            if likeNotification {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding(.trailing, 10)
            } else if followNotification {
                Button(action: {
                    // Follow back logic
                }) {
                    Text("Follow back")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }

}

struct SingleNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SingleNotificationView()
    }
}
