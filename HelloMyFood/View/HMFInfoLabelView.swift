//
//  HMFInfoLabelView.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

import UIKit

class HMFInfoLabelView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("HMFInfoLabelView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
