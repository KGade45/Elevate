//
//  AccountView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct AccountTopCardView: View {
    @State private var isSelf: Bool = false
    @GestureState private var isPressing = false
    
    var body: some View {
        let longPressGesture = LongPressGesture(minimumDuration: 0.1)
            .updating($isPressing) { currentState, gestureState, _ in
                gestureState = currentState
            }
        VStack {
            HStack(alignment: .center, spacing: 16) {
                Image("Nature")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .scaleEffect(isPressing ? 1.5 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: isPressing)
                    .gesture(longPressGesture)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("UserModel name")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("UserModel Headline description")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            HStack {
                Button {
                    
                } label: {
                    Text("Follow")
                            .font(.body)
                            .foregroundStyle(Color(.systemBlue))
                            .padding(.horizontal, 150)
                            .padding(.vertical, 5)
                            .overlay(
                                Capsule()
                                    .stroke(Color(.systemBlue), lineWidth: 1)
                            )
                }
            }
        }
    }
}


struct AccountTopCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTopCardView()
    }
}
