//
//  CommentBottomsheet.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct CommentBottomsheet: View {
    @State private var isEmptyComment: Bool = true
    @State private var newComment: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Group {
                if isEmptyComment {
                    EmptyCommentView()
                } else {
                    CommentsView()
                }
            }
            .frame(maxHeight: .infinity)

            Divider()

            HStack {
                TextField("Add a comment...", text: $newComment)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Button(action: {
                    submitComment()
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.blue)
                }
                .disabled(newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
            .background(Color.white)
        }
        .presentationDetents([.medium, .large])
    }

    func submitComment() {
        guard !newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        print("Submitted comment: \(newComment)")
        newComment = ""
        isEmptyComment = false
    }
}


struct CommentBottomsheet_Previews: PreviewProvider {
    static var previews: some View {
        CommentBottomsheet()
    }
}
