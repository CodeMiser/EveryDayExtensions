//
//  ViewController.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/5/19.
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

class ViewController: UIViewController, UIApplicationDelegate {

    let identifiers = [
        UIButtonCell.identifier,
        UIColorCell.identifier,
        UIFontCell.identifier,
        UITextFieldCell.identifier,
        UIViewCell.identifier,
        ]

    @IBOutlet weak var attributedStringLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        Log(self)

        self.attributedStringLabel.attributedText = "*EveryDay*Extensions\n=PURE= _Awesomeness_!".attributed()
        self.datePicker.backgroundColor = .black
        self.datePicker.textColor = .white
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Log(self)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Log(self)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Log(self)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Log(self)
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.identifiers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.identifiers[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        switch cell {
        case let buttonCell as UIButtonCell:
            buttonCell.configure(for: indexPath)
        case let colorCell as UIColorCell:
            colorCell.configure(for: indexPath)
        case let fontCell as UIFontCell:
            fontCell.configure(for: indexPath)
        case let textFieldCell as UITextFieldCell:
            textFieldCell.configure(for: indexPath)
        case let viewCell as UIViewCell:
            viewCell.configure(for: indexPath)
        default:
            break
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 64
        switch self.identifiers[indexPath.row] {
        case UIViewCell.identifier: height = 256
        default: break
        }
        return CGFloat(height);
    }
}

//MARK: -

class UIButtonCell: UITableViewCell {
    static let identifier = "UIButtonCell"

    @IBOutlet weak var button: UIButton!

    @IBAction func tap(button: UIButton) {
        button.isEnabled = !button.isEnabled

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            button.isEnabled = true
        }
    }

    func configure(for indexPath: IndexPath) {
        let darkBlue = UIColor(red: 0, green: 122.0/255.0 * 0.5, blue: 0.5, alpha: 1.0)
        self.button.title = "self.button.textColor = (.white, darkBlue)"
        self.button.textColor = (.white, darkBlue)
    }
}

class UIColorCell: UITableViewCell {
    static let identifier = "UIColorCell"

    @IBOutlet weak var view: UIView!

    func configure(for indexPath: IndexPath) {
        self.view.backgroundColor = .defaultTintColor
    }
}

class UIFontCell: UITableViewCell {
    static let identifier = "UIFontCell"

    @IBOutlet weak var fontLabel: UILabel!

    func configure(for indexPath: IndexPath) {
        self.fontLabel.font = UIFont.sanFrancisco(24, .thin)
    }
}

class UITextFieldCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "UITextFieldCell"

    @IBOutlet weak var textField: UITextField!

    func configure(for indexPath: IndexPath) {
        self.textField.delegate = self
        self.textField.placeholderTextColor = .white
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
}

class UIViewCell: UITableViewCell {
    static let identifier = "UIViewCell"

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var cornerRadiusView: UIView!

    func configure(for indexPath: IndexPath) {
        self.roundedView.rounded = true
        self.cornerRadiusView.cornerRadius = 32
    }
}
