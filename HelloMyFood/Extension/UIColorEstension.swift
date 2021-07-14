//
//  UIColorEstension.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

extension UINavigationController {

    func setNavigationBarBorderColor(color: UIColor) {
        self.navigationBar.shadowImage = color.as1ptImage()
    }
}

extension UIColor {

    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }

    convenience init(argb: Int) {
        let red: CGFloat = CGFloat((argb >> 16) & 0xff) / 255.0
        let green: CGFloat = CGFloat((argb >> 8) & 0xff) / 255.0
        let blue: CGFloat = CGFloat(argb & 0xff) / 255.0
        let alpha: CGFloat = CGFloat((argb >> 24) & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(_ netHex: Int, alpha: CGFloat = 1.0) {

        let red: CGFloat = CGFloat((netHex >> 16) & 0xff) / 255.0
        let green: CGFloat = CGFloat((netHex >> 8) & 0xff) / 255.0
        let blue: CGFloat = CGFloat(netHex & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
