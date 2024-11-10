//
//  OverflowUsers.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/10/24.
//  Copyright © 2024 FTLapps, inc. All rights reserved.
//

import Foundation

typealias OverflowUsers = NetworkCollection<OverflowUser>

class OverflowUser: Decodable {
    let acceptRate: Int?
    struct BadgeCounts: Decodable {
        let bronze: Int
        let gold: Int
        let silver: Int
    }
    let badgeCounts: BadgeCounts
    let displayName: String
    let location: String?
    let profileImage: String? // avatar icon is nil unless requested
    let reputation: Int
    let userId: Int
}
