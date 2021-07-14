//
//  ViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

class ViewController: HMFBaseUIViewController {

    @IBOutlet var views: MainViews!

    override func viewDidLoad() {
        super.viewDidLoad()

        views.randomBtn.addTarget(self, action: #selector(randomBtnPressed), for: .touchUpInside)
        views.generateBtn.addTarget(self, action: #selector(generateBtnPressed), for: .touchUpInside)
        
    }

    @objc
    private func randomBtnPressed() {
        views.countTextField.text = "\(Int.random(in: 1..<21))"
    }

    @objc
    private func generateBtnPressed() {
        if let string = views.countTextField.text, let value = Int(string) {
            guard value != 0 && value <= 21 else { return }
            let vc = UIStoryboard.loadHMFProfileViewController()
            vc.count = value
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITextFieldDelegate {

}

extension ViewController: HMFAPInfoDelegate {

    func didFetchAPIResponse(dataString: String) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.views.consolLogView.text = dataString
            //TOOD: UI尚未100%相同，待解決
        }
    }
}
