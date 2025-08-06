//
//  ProfileView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            AccountTopCardView()
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
