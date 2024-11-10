//
//  OverflowAPI.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/10/24.
//  Copyright © 2024 FTLapps, inc. All rights reserved.
//

import Foundation

extension NetworkAPI {

    func fetchUsers(completion: @escaping (OverflowUsers?) -> Void) {
        NetworkRequest(.GET, "/2.3/users", parameters: [
            "order": "desc",
            "pagesize": 1,
            //"page": page,
            "site": "stackoverflow",
            "sort": "reputation",
        ]).execute(completion: completion)
    }
}
