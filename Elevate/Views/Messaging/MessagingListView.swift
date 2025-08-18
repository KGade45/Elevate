//
//  MessagingListView.swift
//  Elevate
//
//  Created by Kaustubh Gade on 06/08/25.
//

import SwiftUI

struct MessagingListView: View {
    var body: some View {
        VStack {
            MessageUserCell()
            MessageUserCell()
            MessageUserCell()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct MessagingListView_Previews: PreviewProvider {
    static var previews: some View {
        MessagingListView()
    }
}
