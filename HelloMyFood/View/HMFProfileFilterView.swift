//
//  HMFHMFProfileFilterView.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//


private let identifier = "ProfileFilterCell"

protocol HMFProfileFilterViewDelegate: AnyObject {
    func filterView(view: HMFProfileFilterView, didSelect index: Int, status: HMFProfileFilterOptions)
}

class HMFProfileFilterView: UICollectionReusableView {

    weak var delegate: HMFProfileFilterViewDelegate?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let abovelineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.register(HMFProfileFilterCell.self, forCellWithReuseIdentifier: identifier)

        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)

        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }

    override func layoutSubviews() {
        addSubview(abovelineView)
        abovelineView.anchor(left: leftAnchor, bottom: topAnchor, width: frame.width, height: 0.5)

        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HMFProfileFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HMFProfileFilterOptions.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HMFProfileFilterCell

        let option = HMFProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option

        return cell
    }
}

extension HMFProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let xPosition = cell?.frame.origin.x ?? 0

        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
        if let status = HMFProfileFilterOptions(rawValue: indexPath.row) {
            delegate?.filterView(view: self, didSelect: indexPath.row, status: status)
        }
    }
}

extension HMFProfileFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(HMFProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


enum HMFProfileFilterOptions: Int, CaseIterable {
    case post
    case list
    case tag

    var systemImage: UIImage? {
        switch self {
        case .post: return #imageLiteral(resourceName: "icon_grid")
        case .list: return #imageLiteral(resourceName: "icon_list")
        case .tag: return #imageLiteral(resourceName: "icon_profile")
        }
    }
}
