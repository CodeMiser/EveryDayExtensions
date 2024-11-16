//
//  StartupViewController.swift
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

class StartupViewController: UIViewController, Storyboardable {

    static var storyboardName: String { "Startup" }

    @IBOutlet private var attributedStringLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var datePicker: UIDatePicker!

    private let cellTypes: [UITableViewCell.Type] = [
        UIAlertControllerCell.self,
        UIButtonCell.self,
        UIColorCell.self,
        UIFontCell.self,
        UITextFieldCell.self,
        UIViewCell.self,
        UIDatePickerButtonCell.self,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        Log(self)

        StringStyles.setDefaultStyles(normal: .black, .sanFrancisco(24, .thin),
                                      bold: .black, .sanFrancisco(24, .bold),
                                      highlight: .red, .italicSanFrancisco(24, .thin),
                                      title: .defaultTintColor, .sanFrancisco(36, .thin))

        self.attributedStringLabel.attributedText = "*EveryDay*Extensions\n=PURE= _Awesomeness_!".attributed()

        self.datePicker.backgroundColor = .black
        self.datePicker.textColor = .white
        self.datePicker.isHidden = true
    }

    // MARK: - Actions

    @IBAction private func overflow(barButtonItem: UIBarButtonItem) {
        let vc = OverflowViewController.makeFromStoryboard()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIApplicationDelegate

extension StartupViewController: UIApplicationDelegate {

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

// MARK: - UITableViewDataSource

extension StartupViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.cellTypes[indexPath.row]
        let cell = cellType.cell(from: tableView, for: indexPath)
        switch cell {
        case let alertControllerCell as UIAlertControllerCell:
            alertControllerCell.configure(for: indexPath)
        case let buttonCell as UIButtonCell:
            buttonCell.configure(for: indexPath)
        case let colorCell as UIColorCell:
            colorCell.configure(for: indexPath)
        case let fontCell as UIFontCell:
            fontCell.configure(for: indexPath)
        case let textFieldCell as UITextFieldCell:
            textFieldCell.configure(for: indexPath)
            textFieldCell.didBeginEditing = { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
            textFieldCell.didTapDone = {
                // do nothing
            }
        case let viewCell as UIViewCell:
            viewCell.configure(for: indexPath)
        case let datePickerButtonCell as UIDatePickerButtonCell:
            datePickerButtonCell.configure(for: indexPath)
            datePickerButtonCell.didTapButton = { [weak self] in
                UIView.animate(withDuration: animationDuration) {
                    self?.datePicker.isHidden = !(self?.datePicker.isHidden ?? false)
                }
                DispatchQueue.main.async {
                    self?.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        default:
            break
        }
        return cell
    }
}

//MARK: - UIAlertControllerCell

class UIAlertControllerCell: UITableViewCell {

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

    func configure(for indexPath: IndexPath) {
        // no configuration change
    }
}

// MARK: - UIButtonCell

class UIButtonCell: UITableViewCell {

    @IBOutlet private var button: UIButton!

    @IBAction func tap(button: UIButton) {
        button.isEnabled = false

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            button.isEnabled = true
        }
    }

    func configure(for indexPath: IndexPath) {
        self.button.title = "self.button.textColor = (.white, .darkGray)"
        self.button.textColor = (.white, .darkGray)
    }
}

// MARK: - UIColorCell

class UIColorCell: UITableViewCell {

    @IBOutlet private var view: UIView!

    @IBOutlet private var red: UIView!
    @IBOutlet private var yellow: UIView!
    @IBOutlet private var green: UIView!
    @IBOutlet private var cyan: UIView!
    @IBOutlet private var blue: UIView!
    @IBOutlet private var magenta: UIView!

    @IBOutlet private var darkRed: UIView!
    @IBOutlet private var darkYellow: UIView!
    @IBOutlet private var darkGreen: UIView!
    @IBOutlet private var darkCyan: UIView!
    @IBOutlet private var darkBlue: UIView!
    @IBOutlet private var darkMagenta: UIView!

    func configure(for indexPath: IndexPath) {
        self.view.backgroundColor = .defaultTintColor

        // https://en.wikipedia.org/wiki/Enhanced_Graphics_Adapter
        self.red.backgroundColor = UIColor(hex: "#FF5555")
        self.yellow.backgroundColor = UIColor(hex: "#FFFF55")
        self.green.backgroundColor = UIColor(hex: "#55FF55")
        self.cyan.backgroundColor = UIColor(hex: "#55FFFF")
        self.blue.backgroundColor = UIColor(hex: "#5555FF")
        self.magenta.backgroundColor = UIColor(hex: "#FF55FF")

        self.darkRed.backgroundColor = UIColor(hex: 0xAA0000)
        self.darkYellow.backgroundColor = UIColor(hex: 0xAAAA00)
        self.darkGreen.backgroundColor = UIColor(hex: 0x00AA00)
        self.darkCyan.backgroundColor = UIColor(hex: 0x00AAAA)
        self.darkBlue.backgroundColor = UIColor(hex: 0x0000AA)
        self.darkMagenta.backgroundColor = UIColor(hex: 0xAA0080)
    }
}

// MARK: - UIFontCell

class UIFontCell: UITableViewCell {

    @IBOutlet private var fontLabel: UILabel!

    func configure(for indexPath: IndexPath) {
        self.fontLabel.font = UIFont.sanFrancisco(24, .thin)
    }
}

// MARK: - UITextFieldCell

class UITextFieldCell: UITableViewCell, UITextFieldDelegate {

    var didBeginEditing: (() -> Void)?
    var didTapDone: (() -> Void)?

    @IBOutlet private var textField: UITextField!

    func configure(for indexPath: IndexPath) {
        self.textField.delegate = self
        self.textField.placeholderTextColor = .white
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.didBeginEditing?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()

        self.didTapDone?()
        return true
    }
}

// MARK: - UIViewCell

class UIViewCell: UITableViewCell {

    @IBOutlet private var roundedView: UIView!
    @IBOutlet private var cornerRadiusView: UIView!

    func configure(for indexPath: IndexPath) {
        //self.roundedView.rounded = true
        //self.cornerRadiusView.cornerRadius = 32
    }
}

// MARK: - UIDatePickerButtonCell

class UIDatePickerButtonCell: UITableViewCell {

    var didTapButton: (() -> Void)?

    @IBOutlet private var toggleDataPickerButton: UIButton!

    func configure(for indexPath: IndexPath) {
        // nothing to configure
    }

    @IBAction func toggleDatePicker(button: UIButton) {
        self.didTapButton?()
    }
}
