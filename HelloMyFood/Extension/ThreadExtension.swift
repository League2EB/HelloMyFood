//
//  ThreadExtension.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/15.
//

public func onMainThread(block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
}
