//
//  SignUpView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import SwiftUI
import PhotosUI

// MARK: - ViewModel
@MainActor
class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var photoPickerViewModel = PhotoPickerViewModel()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let imageService = ImageService()
    
    var isValidPassword: Bool {
        guard !password.isEmpty else { return false }
        return password == confirmPassword
    }
    
    func signUp(authViewModel: Appwrite, router: Router) async {
        guard isValidPassword else {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            // 1. Register the user with Appwrite
            let user = try await authViewModel.onRegister(email, password, fullName)
            
            // 2. Handle profile photo upload
            if let imageToUpload = photoPickerViewModel.selectedImage {
                let photoId = await imageService.uploadImage(image: imageToUpload)
                
                // 3. Update the user's profile with the new photo ID
                if let photoId = photoId {
                    await authViewModel.updateUserInfo(userPrefs: ["profilePhotoId": photoId])
                    print("Successfully updated profile photo.")
                } else {
                    print("Warning: Photo upload failed. Profile photo ID not updated.")
                }
            }
            
            // 4. Navigate to the main app screen
            router.navigateToRoot()
            
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
            print("Error during registration: \(error.localizedDescription)")
        }
    }
}


// MARK: - View
struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject var authViewModel: Appwrite
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 24) {
            
            PhotosPicker(selection: $viewModel.photoPickerViewModel.imageSelection, matching: .images) {
                ZStack {
                    if let image = viewModel.photoPickerViewModel.selectedImage {
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
                CustomTextField(placeholder: "Full Name", text: $viewModel.fullName, shouldShowBox: true)
                CustomTextField(placeholder: "Email", text: $viewModel.email, shouldShowBox: true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                CustomTextField(placeholder: "Password", text: $viewModel.password, isSecureTextField: true, shouldShowBox: true)
                    .textContentType(.newPassword)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            
            // Confirm Password with status icon
            ZStack(alignment: .trailing) {
                CustomTextField(
                    placeholder: "Confirm Password",
                    text: $viewModel.confirmPassword,
                    isSecureTextField: true,
                    shouldShowBox: true
                )
                .textContentType(.newPassword)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                
                if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                    Image(systemName: viewModel.isValidPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(viewModel.isValidPassword ? .green : .red)
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
                    await viewModel.signUp(authViewModel: authViewModel, router: router)
                }
            }
            .clipShape(Capsule())
            .disabled(viewModel.isLoading)
            .opacity(viewModel.isLoading ? 0.5 : 1.0)
        }
        .padding(.horizontal)
        .padding(.bottom, 40)
        .navigationTitle("Sign Up")
        .ignoresSafeArea(.keyboard)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Sign Up Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(Appwrite())
}
