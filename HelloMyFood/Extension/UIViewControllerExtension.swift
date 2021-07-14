//
//  UIViewControllerExtension.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

extension UIViewController {

    /// 類別名稱
    /// - Returns: 看得懂的字串
    func className() -> String {
        let describing = String(describing: self)
        if let dotIndex = describing.firstIndex(of: "."), let commaIndex = describing.firstIndex(of: ":") {
            let afterDotIndex = describing.index(after: dotIndex)
            if(afterDotIndex < commaIndex) {
                return String(describing[afterDotIndex ..< commaIndex])
            }
        }
        return describing
    }
}
