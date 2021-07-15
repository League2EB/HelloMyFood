//
//  HMFMainViews.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

class HMFMainViews: NSObject {

    /// 數字輸入框
    @IBOutlet weak var countTextField: UITextField!
    /// Log顯示畫面
    @IBOutlet weak var consolLogView: UITextView!
    /// 隨機產生1-20隨機數字按鈕
    @IBOutlet weak var randomBtn: HMFRoundCornersButton!
    /// 產生按鈕
    @IBOutlet weak var generateBtn: HMFRoundCornersButton!
}
