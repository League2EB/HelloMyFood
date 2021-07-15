//
//  HMFProfileFilterCell.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

class HMFProfileFilterCell: UICollectionViewCell {

    var option: HMFProfileFilterOptions! {
        didSet { imageView.image = option.systemImage }
    }

    private var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor(0x5395ea) : .lightGray
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.tintColor = .lightGray
        imageView.setDimensions(width: 24, height: 24)
        imageView.center(inView: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
