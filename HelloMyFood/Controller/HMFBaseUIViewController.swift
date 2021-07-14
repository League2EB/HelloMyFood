//
//  HMFBaseUIViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//


class HMFBaseUIViewController: UIViewController {

    deinit {
        NSLog("%@釋放", self.className())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.setNavigationBarBorderColor(color: UIColor(0xb2b2b2))
    }

    /// 新增左上角導航欄按鈕
    /// - Parameters:
    ///   - imageName: 圖片名稱
    ///   - type: 行為
    func addLeftButtonItem(image: UIImage) {
        let popBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(HMFBaseUIViewController.perviousBack))
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
