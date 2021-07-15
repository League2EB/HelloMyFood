//
//  HMFRoundCornersImageView.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

class HMFRoundCornersImageView: UIImageView {

    private var firstInit: Bool = false

    /**
     左上角圓角
     */
    @IBInspectable var leftTop: Bool = false

    /**
     左下角圓角
     */
    @IBInspectable var leftBotton: Bool = false

    /**
     右上角圓角
     */
    @IBInspectable var rightTop: Bool = false

    /**
     右下角圓角
     */
    @IBInspectable var rightBottom: Bool = false

    /**
     圓角比例，預設為0.5，代表正圓形
     */
    @IBInspectable var roundCornersRatio: CGFloat = 0.5

    /**
     邊框寬度
     要大於0才會有邊框效果
     */
    @IBInspectable var borderWidth: CGFloat = 0

    /**
     邊框顏色
     */
    @IBInspectable var borderColor: UIColor = UIColor.clear

    /**
     圓角的遮罩Layer
     */
    private var roundCornersMask: CAShapeLayer? = nil

    /**
     邊框Layer
     */
    private var borderLayer: CAShapeLayer? = nil

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()

        let cornerRadii = self.bounds.height * roundCornersRatio

        var roundingCorners: UInt = 0

        if leftTop {
            roundingCorners = roundingCorners | UIRectCorner.topLeft.rawValue
        }

        if leftBotton {
            roundingCorners = roundingCorners | UIRectCorner.bottomLeft.rawValue
        }

        if rightTop {
            roundingCorners = roundingCorners | UIRectCorner.topRight.rawValue
        }

        if rightBottom {
            roundingCorners = roundingCorners | UIRectCorner.bottomRight.rawValue
        }

        //第一次初始化
        if firstInit == false {
            roundCornersMask = CAShapeLayer()

            if let roundCornersMask = roundCornersMask {
                roundCornersMask.path = UIBezierPath(roundedRect: self.bounds,
                    byRoundingCorners: UIRectCorner.init(rawValue: roundingCorners),
                    cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)).cgPath

                if borderWidth > 0 {
                    borderLayer = CAShapeLayer()

                    if let borderLayer = borderLayer {
                        borderLayer.path = roundCornersMask.path
                        borderLayer.fillColor = UIColor.clear.cgColor
                        borderLayer.strokeColor = borderColor.cgColor
                        borderLayer.lineWidth = borderWidth

                        self.layer.addSublayer(borderLayer)
                    }
                }
            }

            self.layer.mask = roundCornersMask

            firstInit = true
        }

        //第二次之後調用的話，只改變圓角遮罩與邊框遮罩的Path還有PressMask的Bounds
        //需要這樣做是因為Autolayout會多次調整大小並調用layoutSubviews
        if let roundCornersMask = roundCornersMask {
            roundCornersMask.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.init(rawValue: roundingCorners), cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)).cgPath

            if let borderLayer = borderLayer {
                borderLayer.path = roundCornersMask.path
            }
        }
    }
}

