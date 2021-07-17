//
//  HMFMainViewModel.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/16.
//

import RxCocoa

class HMFMainViewModel: HMFBaseViewModel {

    /// 亂數
    var randomNumber = BehaviorRelay<String>(value: "")
    /// 輸入框互動
    var userInteractionEnabled = BehaviorRelay<Bool>(value: true)

    private var timer = HMFTimer(timeInterval: 0.05, isInMainQueue: true)
    private var tickTimes: Int = 0

    func timerTick() {
        timer.trigger = { [weak self] tick in
            guard let `self` = self else { return }
            self.randomNumber.accept("\(Int.random(in: 1..<21))")
            self.tickTimes += 1
            if self.tickTimes >= 20 {
                self.timer.stopTimer()
                self.tickTimes = 0
                self.userInteractionEnabled.accept(true)
            }
        }
        timer.startTimer()
        userInteractionEnabled.accept(false)
    }
}
