//
//  EmptyCommentView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct EmptyCommentView: View {
    var body: some View {
        VStack {
            Image("EmptyComment")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 350)
            Text("Be the first to comment")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

struct EmptyCommentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCommentView()
    }
}
