//
//  View+Ext.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import Foundation

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
