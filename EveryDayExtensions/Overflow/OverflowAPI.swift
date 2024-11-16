//
//  OverflowAPI.swift
//  EveryDayExtensions
//
//  Created by Mark on 11/10/24.
//  Copyright © 2024 FTLapps, inc. All rights reserved.
//

import Foundation

extension NetworkAPI {

    func fetchUsers(page: Int, pageSize: Int, completion: @escaping (OverflowUsers?) -> Void) {
        NetworkRequest(.GET, "/2.3/users", parameters: [
            "order": "desc",
            "site": "stackoverflow",
            "sort": "reputation",
        ]).executePaging(page: page, pageSize: pageSize, completion: completion)
    }
}
