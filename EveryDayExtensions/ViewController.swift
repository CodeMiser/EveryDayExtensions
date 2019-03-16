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

class ViewController: UIViewController {

    let identifiers = [
        UIAlertControllerCell.identifier,
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
}

extension ViewController: UIApplicationDelegate {

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
//        case let alertControllerCell as UIAlertControllerCell:
//            alertControllerCell.configure(for: indexPath)
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
        case UIColorCell.identifier: height = 128
        case UIViewCell.identifier: height = 256
        default: break
        }
        return CGFloat(height);
    }
}

//MARK: -

class UIAlertControllerCell: UITableViewCell {
    static let identifier = "UIAlertControllerCell"

    @IBAction func alert(button: UIButton) {
        UIAlertController.alert(title: "Alert!", message: "Hello World").addButton(title: "OK").show()
    }

    @IBAction func alertCancel(button: UIButton) {
        UIAlertController.alert(title: "Alert", message: "Are you sure you want to continue?")
            .addButton(title: "Yes!") { (UIAlertAction) in
                UIAlertController.showAlert(title: "Continue!")
            }
            .addCancelButton()
            .show()
    }

    @IBAction func alertDelete(button: UIButton) {
        UIAlertController.alert(title: "Delete file?")
            .addDestructiveButton(title: "Delete") { (UIAlertAction) in
                UIAlertController.showAlert(title: "Deleted!")
            }
            .addCancelButton()
            .show()
    }

    @IBAction func sheet(button: UIButton) {
        UIAlertController.sheet()
            .addButton(title: "Happy") { (UIAlertAction) in
                UIAlertController.showAlert(title: "I am happy!", button: "Yay!")
            }
            .addButton(title: "Sad") { (UIAlertAction) in
                UIAlertController.showAlert(title: "I am sad...", button: "Aww I'm sorry. Now I'm sad too...")
            }
            .addCancelButton()
            .show()
    }

    @IBAction func sheetDelete(button: UIButton) {
        UIAlertController.sheet(title: "Delete", message: "OK to delete the file?")
            .addDestructiveButton(title: "Delete") { (UIAlertAction) in
                UIAlertController.showAlert(title: "Deleted!")
            }
            .addCancelButton()
            .show()
    }

//    func configure(for indexPath: IndexPath) {
//    }
}

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

    @IBOutlet weak var red: UIView!
    @IBOutlet weak var yellow: UIView!
    @IBOutlet weak var green: UIView!
    @IBOutlet weak var cyan: UIView!
    @IBOutlet weak var blue: UIView!
    @IBOutlet weak var magenta: UIView!

    @IBOutlet weak var darkRed: UIView!
    @IBOutlet weak var darkYellow: UIView!
    @IBOutlet weak var darkGreen: UIView!
    @IBOutlet weak var darkCyan: UIView!
    @IBOutlet weak var darkBlue: UIView!
    @IBOutlet weak var darkMagenta: UIView!

    func configure(for indexPath: IndexPath) {
        self.view.backgroundColor = .defaultTintColor

        // https://en.wikipedia.org/wiki/Enhanced_Graphics_Adapter
        self.red.backgroundColor = UIColor(hex: "#FF5555")
        self.yellow.backgroundColor = UIColor(hex: "#FFFF55")
        self.green.backgroundColor = UIColor(hex: "#55FF55")
        self.cyan.backgroundColor = UIColor(hex: "#55FFFF")
        self.blue.backgroundColor = UIColor(hex: "#5555FF")
        self.magenta.backgroundColor = UIColor(hex: "#FF55FF")

        self.darkRed.backgroundColor = UIColor(hex: "#AA0000")
        self.darkYellow.backgroundColor = UIColor(hex: "#AAAA00")
        self.darkGreen.backgroundColor = UIColor(hex: "#00AA00")
        self.darkCyan.backgroundColor = UIColor(hex: "#00AAAA")
        self.darkBlue.backgroundColor = UIColor(hex: "#0000AA")
        self.darkMagenta.backgroundColor = UIColor(hex: "#AA0080")
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
