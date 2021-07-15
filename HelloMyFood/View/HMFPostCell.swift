//
//  HMFPostCell.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

class HMFPostCell: UICollectionViewCell {

    let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5

        addSubview(postImageView)
        postImageView.addConstraintsToFillView(self)
        postImageView.center(inView: self)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

