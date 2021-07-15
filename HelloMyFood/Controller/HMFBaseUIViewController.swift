//
//  HMFBaseUIViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//


class HMFBaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.setNavigationBarBorderColor(color: UIColor(0xb2b2b2))
    }
}
