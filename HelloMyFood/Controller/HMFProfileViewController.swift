//
//  HMFProfileViewController.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

import RxCocoa
import RxSwift

private let headerIdentifier = "filterHeader"
private let profileIdentifier = "profileCell"
private let identifier = "postCell"

protocol HMFAPInfoDelegate: AnyObject {
    func didFetchAPIResponse(dataString: String)
}

class HMFProfileViewController: UICollectionViewController {

    let bag: DisposeBag = DisposeBag()

    /// 請求總數
    var count: Int = 0

    weak var delegate: HMFAPInfoDelegate? = nil
    /// 圖片陣列
    fileprivate var images: [String] = []
    /// 類型
    private var type: HMFProfileFilterOptions = .post

    private let viewModel: HMFProfileViewModel = HMFProfileViewModel()

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

        viewModel.requestFoodData(times: count)
        viewModel.images.bind(to: self.rx.data).disposed(by: bag)
        viewModel.needReload.bind(to: self.rx.isReloadble).disposed(by: bag)

        addLeftButtonItem(image: #imageLiteral(resourceName: "icon_previous").imageResize(sizeChange: CGSize(width: 24, height: 24)))
        configureCollectionView()
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
                cell.asyncLoadImage(with: images[indexPath.row])
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

extension Reactive where Base: HMFProfileViewController {

    var data: Binder<[String]> {
        get {
            return Binder(self.base) { target, value in
                target.images = value
            }
        }
    }

    var isReloadble: Binder<Bool> {
        get {
            return Binder(self.base) { target, value in
                if value {
                    target.collectionView.reloadData()
                }
            }
        }
    }
}
