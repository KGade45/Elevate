//
//  Router.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 18/08/25.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()

    enum AuthFlow: Hashable, Codable {
        case loginwithGoogle
        case loginwithEmail
        case signUp
        case addPost
    }

    func navigate(to destination: AuthFlow) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
