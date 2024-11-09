//
//  UIViewController+Extension.swift
//  EveryDay
//
//  Created by Mark on 9/29/24.
//
// The MIT License (MIT)
//
// Copyright (c) 2024 FTLapps LLC
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

extension UIViewController {

    func setBackButtonSelector(_ selector: Selector) {
        let backButtonTitle = self.navigationController?.viewControllers.dropLast().last?.navigationItem.title ?? "Back"

        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.backward")?.withConfiguration(UIImage.SymbolConfiguration(weight: .semibold))
        config.title = backButtonTitle
        config.imagePadding = 4.667
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -15.667, bottom: 0, trailing: 0)

        let backButton = UIButton(type: .system)
        backButton.configuration = config
        backButton.addTarget(self, action: selector, for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
