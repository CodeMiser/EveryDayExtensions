//
//  UIAlertController+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/10/19.
//  Copyright © 2019 FTLapps, inc. All rights reserved.
//

import UIKit

extension UIAlertController {

    class func showAlert(title: String, message: String? = nil, button buttonTitle: String = "OK") {
        UIAlertController.alert(title: title, message: message)
            .addButton(title: buttonTitle)
            .show()
    }

    class func alert(title: String, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }

    class func alert(title: String, message: String, cancelButtonTitle: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController.alert(title: title, message: message)
        return alert.addCancelButton(title: cancelButtonTitle)
    }

    class func sheet(title: String? = nil, message: String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }

    func addButton(title: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }

    func addCancelButton(title: String = "Cancel", handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .cancel, handler: handler))
        return self
    }

    func addDestructiveButton(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .destructive, handler: handler))
        return self
    }

    func show(barButtonItem: UIBarButtonItem? = nil) {
        if barButtonItem != nil, let popover = self.popoverPresentationController {
            popover.barButtonItem = barButtonItem;
        }
        AppDelegate.topViewController().present(self, animated: true, completion: nil)
    }
}
