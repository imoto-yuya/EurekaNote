//
//  ViewController.swift
//  EurekaNote
//
//  Created by Yuya Imoto on 2018/08/01.
//  Copyright © 2018年 Yuya Imoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var inputScrollView: UIScrollView!

    @IBAction func canncelButton(_ sender: Any) {
    }

    var keyboardSize: NSValue!

    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        // キーボード用のツールバーを表示
        inputTextView.inputAccessoryView = makeToolbar()
        // キーボードを表示する
        inputTextView.becomeFirstResponder()
    }

    override func viewWillLayoutSubviews() {
        updateViewLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateViewLayout() {
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let inputTextViewHeight = screenHeight/8

        inputScrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - keyboardSize.cgRectValue.size.height)
        inputScrollView.contentSize.height = screenHeight

        // ラベルの位置を指定
        titleLabel.center.x = screenWidth/2
        titleLabel.frame.origin.y = inputTextViewHeight - titleLabel.frame.size.height - inputTextViewHeight/8

        // テキストビューのサイズと位置を指定
        inputTextView.frame.size = CGSize(width: screenWidth*0.8, height: screenHeight*0.2)
        inputTextView.center.x = screenWidth/2
        inputTextView.frame.origin.y = inputTextViewHeight

        // カテゴリ選択欄のサイズと位置を指定
        categorySegmentedControl.frame.size.width = inputTextView.frame.size.width
        categorySegmentedControl.center.x = screenWidth/2
        categorySegmentedControl.frame.origin.y = inputTextView.frame.origin.y + inputTextView.frame.size.height + 20
    }

    @objc func showKeyboard(notification: Notification){
        keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
    }

    @objc func saveProcess(_ sender: UIButton) {
    }

    func makeToolbar() -> UIToolbar {
        // キーボード用のツールバーを作成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        // スタイルを設定
        toolbar.barStyle = UIBarStyle.default
        // 画面幅に合わせてサイズを変更
        toolbar.sizeToFit()
        // ツールバーに表示するボタンを設定
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(saveProcess))
        ]
        return toolbar
    }


}

