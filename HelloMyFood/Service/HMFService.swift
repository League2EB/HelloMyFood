//
//  HMFService.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/17.
//

import Moya

enum HMFService {
    case fetchFoodDataWithType(type: FoodCategory)
}

extension HMFService: TargetType {

    var baseURL: URL {
        return URL(string: "\(HMFEnvironmentManager.shared.BASE_URL)")!
    }

    var path: String {
        switch self {
        case .fetchFoodDataWithType(let type):
            return "\(type.rawValue)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchFoodDataWithType:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .fetchFoodDataWithType:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return [:]
    }
}
