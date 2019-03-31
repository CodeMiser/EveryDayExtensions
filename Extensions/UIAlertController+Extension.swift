//
//  UIAlertController+Extension.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/10/19.
//
// The MIT License (MIT)
//
// Copyright (c) 2019 FTLapps, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
