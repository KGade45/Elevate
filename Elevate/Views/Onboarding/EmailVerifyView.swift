//
//  EmailVerifyView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 08/08/25.
//

import SwiftUI

struct EmailVerifyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var password = ""
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.blue)
                        .imageScale(.large)
                }
                
                Spacer()
                
                Text("Continue with Email")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            VStack(spacing: 20) {
                CustomTextField(placeholder: "Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                CustomTextField(placeholder: "Password", text: $password, isSecureTextField: true)
            }
            
            HStack {
                Spacer()
                LoginButton(
                    imageName: "",
                    text: "Forgot password?",
                    paddingHorizontal: 0,
                    foregroundStyle: .black,
                    backgroundColor: Color(.white),
                    fontWeight: .regular
                ) {
                    
                }
                
            }
            .padding(.horizontal, 25)
            
            Button(action: {
                
            }) {
                Text("Continue")
                    .font(.body)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 130)
                    .padding(.vertical, 10)
                    .background(Color(.systemBlue))
                    .clipShape(.capsule)
            }
            .padding(.top, 20)
            
            Spacer()

            Text("—————— Made with ❤️ ——————")
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.bottom, 20)
        }
    }
    func saveChanges() {
        guard isValidForm else {
            return
        }
        print("Continue tapped with name: \(password), email: \(email)")
    }
    
    var isValidForm: Bool {
        guard !password.isEmpty && !email.isEmpty else {
            return false
        }
        
        guard email.isValidEmail else {
            return false
        }
        return true
    }
}

struct EmailVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerifyView()
    }
}
