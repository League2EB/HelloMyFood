//
//  HMFProfileHeaderCell.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//


class HMFProfileHeaderCell: UICollectionViewCell {

    @IBOutlet weak var postsView: HMFInfoLabelView! {
        didSet {
            postsView.countLabel.text = "1.234"
            postsView.describeLabel.text = "posts"
        }
    }
    @IBOutlet weak var followersView: HMFInfoLabelView! {
        didSet {
            followersView.countLabel.text = "9.999"
            followersView.describeLabel.text = "followers"
        }
    }
    @IBOutlet weak var followingView: HMFInfoLabelView! {
        didSet {
            followingView.countLabel.text = "111"
            followingView.describeLabel.text = "following"
        }
    }

    static var nib: UINib {
        return UINib(nibName: "HMFProfileHeaderCell", bundle: Bundle(for: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
