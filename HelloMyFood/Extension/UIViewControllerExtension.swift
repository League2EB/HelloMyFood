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

    /// 新增左上角導航欄按鈕
    /// - Parameters:
    ///   - imageName: 圖片名稱
    ///   - type: 行為
    func addLeftButtonItem(image: UIImage) {
        let popBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(perviousBack))
        popBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = popBtn
    }

    //MARK: - Object
    /// 返回
    @objc
    func perviousBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
