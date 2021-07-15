//
//  HMFCalculatUtil.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

let viewWidth: CGFloat = UIScreen.main.bounds.width
let viewHeight: CGFloat = UIScreen.main.bounds.height

class HMFCalculatUtil {

    static let shared: HMFCalculatUtil = {
        let shared = HMFCalculatUtil()
        return shared
    }()

    private(set) var screenWidth: CGFloat = 0
    private(set) var screenHeight: CGFloat = 0

    private init() {
        let scale = UIScreen.main.nativeScale
        screenWidth = UIScreen.main.nativeBounds.width / scale
        screenHeight = UIScreen.main.nativeBounds.height / scale
    }

    /// 計算寬等比放大縮小
    ///
    /// - Parameter width: 被計算的寬
    /// - Returns: 回傳CGFloat
    func calculateWidthScaleWithSize(width: CGFloat) -> CGFloat {
        let scale = width / CGFloat(414)
        let result = UIScreen.main.bounds.width * scale
        return result
    }

    /// 計算高等比放大縮小
    /// 896:414
    /// - Parameters:
    ///   - width: 物件寬
    ///   - height: 物件高
    /// - Returns: 回傳CGFloat(等比放大後的寬)
    func calculateHeightScaleWithSize(width: CGFloat, height: CGFloat) -> CGFloat {
        // 需要被縮放的物件寬比例，使用設計搞上指定的寬來做為基準
        let scale = width / CGFloat(414)
        // 計算當前物件的寬高比
        let itemScale = height / width
        // 設備寬 x 設計稿上的物件比例 x 當前物件比例
        let result = HMFCalculatUtil.shared.screenWidth * scale * itemScale
        return result
    }
}
