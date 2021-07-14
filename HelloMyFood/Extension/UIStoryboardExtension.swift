//
//  UIStoryboardExtension.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

extension UIStoryboard {

    /// 載入個人頁面控制器
    /// - Returns:
    static func loadHMFProfileViewController() -> HMFProfileViewController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HMFProfileViewController") as! HMFProfileViewController
        return vc
    }
}
