//
//  UITableViewCell+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 10/9/22.
//  Copyright © 2022 FTLapps, inc. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static func cell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: self)
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
