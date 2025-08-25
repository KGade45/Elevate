//
//  Follows.swift
//  Elevate
//
//  Created by Kaustubh kailas gade on 25/08/25.
//

import Foundation

struct Follow: Codable, Identifiable {
    let id: String
    let followerId: String      // the one who follows
    let followingId: String     // the one being followed
    let createdAt: Date
}
