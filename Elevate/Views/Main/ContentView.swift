//
//  ContentView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
//        if authViewModel.userSession == nil {
            OnboardingView()
                .environmentObject(authViewModel)
//        } else {
//            MainTabView()
//                .environmentObject(authViewModel)
//        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
