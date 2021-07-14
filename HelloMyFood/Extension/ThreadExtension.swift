//
//  ThreadExtension.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

public func onBackgroundThread(block: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async(execute: block)
}

public func onBackgroundThreadSync(block: () -> Void) {
    DispatchQueue.global(qos: .background).sync(execute: block)
}

public func onMainThread(block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}

public func onMainThreadSync(block: () -> Void) {
    DispatchQueue.main.sync(execute: block)
}

public func createQueue(_ queueLabel: String) -> DispatchQueue {
    return DispatchQueue(label: queueLabel, qos: .utility, attributes: [.concurrent])
}

public func onBackgroundThreadReturn(_ queueLabel: String) -> DispatchQueue {
    return DispatchQueue(label: queueLabel, qos: .background)
}
