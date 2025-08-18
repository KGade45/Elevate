//
//  MessageUserCell.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct MessageUserCell: View {
    var body: some View {
        HStack (spacing: 20) {
            Image("Nature")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            VStack(alignment: .leading, spacing: 4) {
                Text("UserModel name")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text("Tap to view Messages")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        Divider()
    }
}

struct MessageUserCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageUserCell()
    }
}
