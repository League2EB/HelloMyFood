//
//  HMFAPI.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/17.
//

import RxSwift
import Moya
import ObjectMapper

class HMFAPI {

    private let service = MoyaProvider<HMFService>()

    private lazy var backgroundQueue = {
        return SerialDispatchQueueScheduler(qos: .background)
    }()

    private lazy var mainQueue = {
        return MainScheduler.instance
    }()

    /// 獲取食物資料
    /// - Parameter type: 食物類型
    /// - Returns: 被觀察的食物料物件
    func fetchFoodDataWithType(type: FoodCategory) -> Observable<HMFFoodData> {
        return service.rx.request(.fetchFoodDataWithType(type: type))
            .mapJSON()
            .asObservable()
            .mapObject(type: HMFFoodData.self)
            .subscribe(on: backgroundQueue)
            .observe(on: mainQueue)
    }
}
