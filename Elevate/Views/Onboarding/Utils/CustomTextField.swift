//
//  CustomeTextField.swift
//  Elevate
//
//  Created by Kaustubh Gade on 08/08/25.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecureTextField: Bool = false
    var shouldShowBox: Bool = true

    var body: some View {
        Group {
            if isSecureTextField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: 350)
        .if(shouldShowBox) { view in
            // ✅ Boxed style
            view
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .if(!shouldShowBox) { view in
            // ✅ Minimal underline style
            view
                .background(Color.clear)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.5)),
                    alignment: .bottom
                )
        }
    }
}
