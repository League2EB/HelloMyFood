//
//  HMFMainViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

import RxCocoa
import RxGesture

class HMFMainViewController: HMFBaseUIViewController {

    @IBOutlet var views: HMFMainViews!

    private let viewModel: HMFMainViewModel = HMFMainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        views.randomBtn.rx.tap.subscribe(onNext: { [self] _ in
            self.viewModel.timerTick()
        }).disposed(by: bag)

        views.generateBtn.rx.tap.subscribe(onNext: { [self] _ in
            self.generateBtnPressed()
        }).disposed(by: bag)

        view.rx.tapGesture { rec, _ in
            rec.cancelsTouchesInView = false
        }.when(.recognized).subscribe(onNext: { [self] _ in
            self.view.endEditing(true)
        }).disposed(by: bag)

        viewModel.randomNumber.bind(to: views.countTextField.rx.text).disposed(by: bag)
        viewModel.userInteractionEnabled.bind(to: views.countTextField.rx.isUserInteractionEnabled).disposed(by: bag)
    }

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
}

extension HMFMainViewController: HMFAPInfoDelegate {

    func didFetchAPIResponse(dataString: String) {
        self.views.consolLogView.insertText(String(format: "%@\n", dataString))
    }
}
