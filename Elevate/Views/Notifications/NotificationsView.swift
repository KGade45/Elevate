//
//  NotificationsView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 21/08/25.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            SingleNotificationView()
            SingleNotificationView()
            SingleNotificationView()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
