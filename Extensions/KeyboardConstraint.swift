//
//  KeyboardConstraint.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 10/9/22.
//  Copyright © 2022 FTLapps, inc. All rights reserved.
//

import UIKit

// https://github.com/MengTo/Spring/blob/master/Spring/KeyboardLayoutConstraint.swift

class KeyboardConstraint: NSLayoutConstraint {

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else { return }

        self.constant = keyboardSize.height

        let options = UIView.AnimationOptions(rawValue: curve.uintValue)
        UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options) {
            AppDelegate.rootViewController.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else { return }

        self.constant = 0.0

        let options = UIView.AnimationOptions(rawValue: curve.uintValue)
        UIView.animate(withDuration: TimeInterval(duration.doubleValue), delay: 0, options: options) {
            AppDelegate.rootViewController.view.layoutIfNeeded()
        }
    }
}
