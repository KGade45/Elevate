//
//  Button.swift
//  Elevate
//
//  Created by Kaustubh Gade on 05/08/25.
//

import SwiftUI

struct ButtonView: View {
    var imageName: String?
    var titleText: String?

    var shouldShowImage: Bool = false
    
    
    var body: some View {
        Button(action: {
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        }
    }
        
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
