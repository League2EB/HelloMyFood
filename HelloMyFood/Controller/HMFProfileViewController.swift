//
//  HMFProfileViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

protocol HMFAPInfoDelegate: AnyObject {
    func didFetchAPIResponse(dataString: String)
}

class HMFProfileViewController: HMFBaseUIViewController {

    var count: Int = 0

    weak var delegate: HMFAPInfoDelegate? = nil

    private var randomCategory: FoodCategory = FoodCategory.allCases.randomElement() ?? .biryani

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "League2eb"

        onBackgroundThreadSync {
            for _ in 1...count {
                fetchFoodData(type: randomCategory)
            }
        }

        addLeftButtonItem(image: #imageLiteral(resourceName: "icon_previous").imageResize(sizeChange: CGSize(width: 24, height: 24)))

    }

    /// 獲取食物資料
    /// - Parameter type: 食物類型
    private func fetchFoodData(type: FoodCategory) {
        if let url = URL(string: "\(HMFnvironmentManager.shared.BASE_URL)\(type.rawValue)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("錯誤: \(error.localizedDescription)")
                } else if let _ = response as? HTTPURLResponse, let data = data {

                    if let _ = try? JSONDecoder().decode(FoodData.self, from: data) {
                        DispatchQueue.main.async { [weak self] in
                            guard let `self` = self else { return }
                            //self.views.consolLogView.insertText(String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? "")
                            //TOOD: UI尚未100%相同，待解決
                        }
                    }
                }
            }.resume()
        }
    }
}
