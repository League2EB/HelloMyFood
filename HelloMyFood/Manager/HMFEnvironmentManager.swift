//
//  HMFEnvironmentManager.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

class HMFEnvironmentManager {

    static let shared = HMFEnvironmentManager()

    private init() { }

    final var BASE_URL: String {
        return "https://foodish-api.herokuapp.com/api/images/"
    }
}
