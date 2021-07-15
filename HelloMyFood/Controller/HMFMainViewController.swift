//
//  HMFMainViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

class HMFMainViewController: HMFBaseUIViewController {

    @IBOutlet var views: HMFMainViews!

    private var timer = HMFTimer(timeInterval: 0.05, isInMainQueue: true)

    private var tickTimes: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        views.randomBtn.addTarget(self, action: #selector(randomBtnPressed), for: .touchUpInside)
        views.generateBtn.addTarget(self, action: #selector(generateBtnPressed), for: .touchUpInside)
        setupHideKeyboard()
    }

    private func setupHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func randomBtnPressed() {
        timer.trigger = { [weak self] tick in
            guard let `self` = self else { return }
            self.views.countTextField.text = "\(Int.random(in: 1..<21))"
            self.tickTimes += 1
            if self.tickTimes >= 20 {
                self.timer.stopTimer()
                self.tickTimes = 0
            }
        }
        timer.startTimer()
    }

    @objc
    private func generateBtnPressed() {
        let value = Int(views.countTextField.text ?? "0") ?? 0
        if views.countTextField.text == "" || value <= 20 {
            views.consolLogView.text = ""
            let vc = HMFProfileViewController()
            vc.count = value
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

extension HMFMainViewController: HMFAPInfoDelegate {

    func didFetchAPIResponse(dataString: String) {
        self.views.consolLogView.insertText(String(format: "%@\n", dataString))
    }
}
