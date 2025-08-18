//
//  SignUpView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var profilePicData: Data?
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @EnvironmentObject var authViewModel: AuthViewModel
    let appwrite = Appwrite()
    
    var body: some View {
        VStack(spacing: 24) {
            
            ZStack {
                if let profilePicData, let image = UIImage(data: profilePicData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray.opacity(0.6))
                }
            }
            .frame(width: 100, height: 100)
            .background(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2))
            .clipShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 40)
            
            VStack(spacing: 6) {
                Text("Create Your Account")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                
                Text("Please complete all fields to sign up.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            
            
            // Form Fields
            Group {
                CustomTextField(placeholder: "Full Name", text: $fullName, shouldShowBox: true)
                CustomTextField(placeholder: "Email", text: $email, shouldShowBox: true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                CustomTextField(placeholder: "Password", text: $password, isSecureTextField: true, shouldShowBox: true)
                    .textContentType(.newPassword)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            
            // Confirm Password with status icon
            ZStack(alignment: .trailing) {
                CustomTextField(
                    placeholder: "Confirm Password",
                    text: $confirmPassword,
                    isSecureTextField: true,
                    shouldShowBox: true
                )
                .textContentType(.newPassword)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                if !password.isEmpty && !confirmPassword.isEmpty {
                    Image(systemName: isValidPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isValidPassword ? .green : .red)
                        .padding(.trailing, 10)
                        .transition(.scale)
                }
            }
            
            Spacer()
            
            LoginButton(
                imageName: "",
                text: "Create Account",
                paddingHorizontal: 100,
                foregroundStyle: .white,
                backgroundColor: .blue,
                fontWeight: .semibold
            ) {
                Task {
                    do {
                        let user = try await appwrite.onRegister(email, password)
                        print("Successfully registered user: \(user.email)")
                    } catch {
                        print("Error during registration: \(error.localizedDescription)")
                    }
                }
            }
            .clipShape(Capsule())
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
        .navigationTitle("Sign Up")
        .ignoresSafeArea(.keyboard)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem, matching: .images)
        .onChange(of: photoItem) { newItem in
            if let newItem {
                Task {
                    if let data = try await newItem.loadTransferable(type: Data.self) {
                        self.profilePicData = data
                    }
                }
            }
        }
    }

    var isValidPassword: Bool {
        guard !password.isEmpty else { return false }
        return password == confirmPassword
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
