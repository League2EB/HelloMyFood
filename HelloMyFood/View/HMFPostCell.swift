//
//  HMFPostCell.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//
import Kingfisher

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

    func asyncLoadImage(with str: String) {
        let url = URL(string: str)
        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in }
            .onSuccess { result in }
            .onFailure { error in }
            .set(to: postImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

