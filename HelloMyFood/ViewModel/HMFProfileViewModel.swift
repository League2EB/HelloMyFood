//
//  HMFProfileViewModel.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/16.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class HMFProfileViewModel: HMFBaseViewModel {

    /// 需要刷新
    var needReload: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    /// 資料
    var images: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    /// 隨機種類
    private var randomCategory: FoodCategory = FoodCategory.allCases.randomElement() ?? .biryani

    @UserDefault("Images", defaultValue: []) var dbImages: [String]

    func requestFoodData(times: Int) {
        guard times > 0 else {
            self.images.accept(dbImages)
            self.needReload.accept(true)
            return
        }
        api.fetchFoodDataWithType(type: randomCategory)
            .repeatWithBehavior(.immediate(maxCount: UInt(times)))
            .debug("value")
            .subscribe(onNext: { resp in
            self.needReload.accept(true)
            self.images.append(resp.image)
        }, onCompleted: {
                self.dbImages.removeAll()
                self.dbImages = self.images.value
            }).disposed(by: bag)

    }
}
