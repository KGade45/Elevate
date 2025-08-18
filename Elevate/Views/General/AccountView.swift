//
//  ProfileView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
//            EnterOTPView()
            Button {
                authViewModel.signOut()
            } label: {
                Text("sign out")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
