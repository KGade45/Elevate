//
//  AccountView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct AccountTopCardView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image("Nature")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))

            VStack(alignment: .leading, spacing: 4) {
                Text("User name")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text("User Headline description")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}


struct AccountTopCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTopCardView()
    }
}
