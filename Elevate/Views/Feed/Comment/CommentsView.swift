//
//  CommentsView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct CommentsView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 18)
                Text("UserModel name")
                    .foregroundStyle(.black)
                    .fontWeight(.regular)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with")
                .foregroundStyle(.black)
                .fontWeight(.regular)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
