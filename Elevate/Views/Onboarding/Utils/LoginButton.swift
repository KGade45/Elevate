//
//  LoginButton.swift
//  Elevate
//
//  Created by Kaustubh Gade on 08/08/25.
//

import SwiftUI

struct LoginButton: View {
    let imageName: String
    let text: String
    let paddingHorizontal: CGFloat
    let foregroundStyle: Color
    let backgroundColor: Color
    let fontWeight: Font.Weight
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                Text(text)
                    .foregroundStyle(foregroundStyle)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, paddingHorizontal)
            .background(backgroundColor)
            .cornerRadius(8)
            .fontWeight(fontWeight)
        }
    }

}
