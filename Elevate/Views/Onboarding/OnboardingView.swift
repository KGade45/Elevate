//
//  OnboardingView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: Router
    @State private var password = ""
    @State private var email = ""
    @EnvironmentObject var authViewModel: Appwrite

    var body: some View {
        VStack(spacing: 24) {
            
            // Top Logo
            Image("Login")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 250)
                .padding(.top, 20)
            
            Spacer()
            // Text Fields
            CustomTextField(placeholder: "Email", text: $email)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            CustomTextField(placeholder: "Password", text: $password, isSecureTextField: true)
                .textContentType(.password)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            
            // Forgot Password
            HStack {
                Spacer()
                Button("Forgot password?") {
                    // handle forgot password
                }
                .font(.footnote)
                .foregroundStyle(.blue)
            }
            .padding(.trailing, 8)
            

            Button(action: {
                Task {
                    try await authViewModel.onLogin(email, password)
                }
            }) {
                Text("Log in")
                    .font(.body)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBlue))
                    .clipShape(.capsule)
            }
            .padding(.top, 12)
            
            Spacer()
            
            HStack {
                line
                Text("or")
                    .fontWeight(.semibold)
                line
            }
            .foregroundStyle(.gray)
            // Social Login Buttons
            VStack(spacing: 16) {
                LoginButton(
                    imageName: "Google",
                    text: "Continue with Google",
                    paddingHorizontal: 70,
                    foregroundStyle: .black,
                    backgroundColor: Color(.systemGray6),
                    fontWeight: .semibold
                ) {
                    router.navigate(to: .loginwithGoogle)
                }
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.black)
                    
                    Button(action: {
                        router.navigate(to: .signUp)
                    }) {
                        Text("Sign Up")
                            .foregroundStyle(Color(.systemBlue))
                    }
                    .fontWeight(.medium)
                }
            }
            .padding(.bottom, 30)
        }
        .alert("Something went wrong", isPresented: $authViewModel.isError) {}
        .padding(.horizontal, 24)
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1) }
    }
}


#Preview {
    OnboardingView()
        .environmentObject(Appwrite())
}
