//
//  HMFProfileViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

private let headerIdentifier = "filterHeader"
private let profileIdentifier = "profileCell"
private let identifier = "postCell"

protocol HMFAPInfoDelegate: AnyObject {
    func didFetchAPIResponse(dataString: String)
}

class HMFProfileViewController: UICollectionViewController {

    /// 請求總數
    var count: Int = 0

    weak var delegate: HMFAPInfoDelegate? = nil
    /// 隨機種類
    private var randomCategory: FoodCategory = .biryani
    /// 類型
    private var type: HMFProfileFilterOptions = .post
    /// 圖片陣列
    private var images: [String] = []
    /// 調度群組
    private let group = DispatchGroup()

    @UserDefault("Images", defaultValue: []) var dbImages: [String]

    deinit {
        NSLog("%@釋放", self.className())
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "League2eb"

        setupData()

        addLeftButtonItem(image: #imageLiteral(resourceName: "icon_previous").imageResize(sizeChange: CGSize(width: 24, height: 24)))

        configureCollectionView()

    }

    private func setupData() {
        if count == 0 {
            images = dbImages
            collectionView.reloadData()
        } else {
            for _ in 1...count {
                group.enter()
                fetchFoodData(type: randomCategory)
            }
            group.notify(queue: .main) { [self] in
                dbImages.removeAll()
                dbImages = self.images
                self.collectionView.reloadData()
            }
        }
    }

    private func configureCollectionView() {
        collectionView.backgroundColor = .systemGroupedBackground

        collectionView.register(HMFProfileHeaderCell.nib, forCellWithReuseIdentifier: "HMFProfileHeaderCell")
        collectionView.register(HMFPostCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(HMFProfileFilterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.sectionHeadersPinToVisibleBounds = true

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    /// 獲取食物資料
    /// - Parameter type: 食物類型
    private func fetchFoodData(type: FoodCategory) {
        if let url = URL(string: "\(HMFEnvironmentManager.shared.BASE_URL)\(type.rawValue)") {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let `self` = self else { return }
                if let error = error {
                    print("錯誤: \(error.localizedDescription)")
                } else if let _ = response as? HTTPURLResponse, let data = data {

                    if let response = try? JSONDecoder().decode(FoodData.self, from: data) {
                        self.images.append(response.image)
                        onMainThread {
                            self.delegate?.didFetchAPIResponse(dataString: String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? "")
                        }
                    }
                    self.group.leave()
                }
            }.resume()
        }
    }
}

extension HMFProfileViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return images.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HMFProfileHeaderCell", for: indexPath) as! HMFProfileHeaderCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HMFPostCell
            guard images.count > 0 else {
                return cell
            }
            if let _ = URL(string: images[indexPath.row]) {
                cell.postImageView.asyncLoadImageWithURL(url: images[indexPath.row])
            }
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HMFProfileFilterView
        header.delegate = self
        return header
    }
}

extension HMFProfileViewController: HMFProfileFilterViewDelegate {
    func filterView(view: HMFProfileFilterView, didSelect index: Int, status: HMFProfileFilterOptions) {
        type = status
        collectionView.reloadData()
    }
}

extension HMFProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension HMFProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: 0, height: 0)
        default:
            let height: CGFloat = HMFCalculatUtil.shared.calculateHeightScaleWithSize(width: viewWidth, height: 50)
            return CGSize(width: view.frame.width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            /// 設定Header高度
            let height: CGFloat = HMFCalculatUtil.shared.calculateHeightScaleWithSize(width: viewWidth, height: 178)
            return CGSize(width: viewWidth, height: height)
        default:
            var size: CGSize
            switch type {
            case .post:
                size = CGSize(width: viewWidth / 3, height: viewWidth / 3)
            case .list:
                size = CGSize(width: viewWidth, height: HMFCalculatUtil.shared.calculateHeightScaleWithSize(width: viewWidth, height: 100))
            case .tag:
                size = CGSize(width: viewWidth, height: HMFCalculatUtil.shared.calculateHeightScaleWithSize(width: viewWidth, height: 350))
            }
            return size
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
