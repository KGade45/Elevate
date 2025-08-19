//
//  ContentView.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: Appwrite
    var body: some View {
        if authViewModel.userSession == nil {
            OnboardingView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Appwrite())
}
