//
//  ViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        onBackgroundThreadSync {
            for _ in 1...10 {
                fetchFoodData(type: .biryani)
            }
        }
    }

    /// 獲取食物資料
    /// - Parameter type: 食物類型
    private func fetchFoodData(type: FoodCategory) {
        if let url = URL(string: "\(HMFnvironmentManager.shared.BASE_URL)\(type.rawValue)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("錯誤: \(error.localizedDescription)")
                } else if let _ = response as? HTTPURLResponse, let data = data {
                    let decoder = JSONDecoder()

                    if let fooddata = try? decoder.decode(FoodData.self, from: data) {
                        DispatchQueue.main.async {
                            //TODO: - UI刷新
                        }
                        NSLog("\(fooddata.image)")
                    }
                }
            }.resume()
        }
    }
}
