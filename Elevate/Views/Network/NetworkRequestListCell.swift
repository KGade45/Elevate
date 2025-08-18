//
//  NetworkRequestListCell.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct NetworkRequestListCell: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Text("UserModel name")
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)
                .layoutPriority(1)
            
            Spacer()

            HStack(spacing: 8) {
                Button(action: {
                    print("Reject")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
                
                Button(action: {
                    print("Accept")
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct NetworkRequestListCell_Previews: PreviewProvider {
    static var previews: some View {
        NetworkRequestListCell()
    }
}
