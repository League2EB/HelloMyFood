//
//  HMFTimer.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

public class HMFTimer {

    private var baseTimer: Timer? = nil

    private var isInMainQueue: Bool = false

    public var timeInterval: TimeInterval

    public var trigger: ((Timer) -> Void)? = nil

    public var started: Bool { get { return baseTimer != nil } }

    public init(timeInterval: TimeInterval, isInMainQueue: Bool) {
        self.timeInterval = timeInterval
        self.isInMainQueue = isInMainQueue
    }

    @discardableResult
    public func startTimer() -> Bool {
        if baseTimer != nil {
            return false
        }

        baseTimer = Timer.scheduledTimer(timeInterval: timeInterval,
            target: self,
            selector: #selector(cycleTrigger),
            userInfo: nil,
            repeats: true)

        if isInMainQueue {
            RunLoop.main.add(baseTimer!, forMode: .common)
        }

        return true
    }

    public func stopTimer() {
        if baseTimer == nil {
            return
        }

        baseTimer?.invalidate()
        self.baseTimer = nil
    }

    @objc
    private func cycleTrigger(timer: Timer) {
        trigger?(timer)
    }
}
