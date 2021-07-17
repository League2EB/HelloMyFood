//
//  Observable+ObjectMapper.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/17.
//

import RxSwift
import Moya
import ObjectMapper

extension Observable {

    public func mapObject<T:Mappable>(type: T.Type) -> Observable<T> {

        return self.map { response in

            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            if let error = self.parseError(response: dict) {
                throw error
            }
            return Mapper<T>().map(JSON: dict)!
        }
    }

    public func mapArray<T:Mappable>(type: T.Type) -> Observable<[T]> {

        return self.map { response in

            guard let array = response as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }

            for dict: [String: Any] in array {
                if let error = self.parseError(response: dict) {
                    throw error
                }
            }
            return Mapper<T>().mapArray(JSONArray: array)
        }
    }

    final fileprivate func parseError(response: [String: Any]?) -> NSError? {

        var error: NSError?

        if let value = response {
            var code: Int?
            var msg: String?

            if let errorDic = value["error"] as? [String: Any] {

                code = errorDic["code"] as? Int
                msg = errorDic["msg"] as? String
                error = NSError(domain: "Network", code: code!, userInfo: [NSLocalizedDescriptionKey: msg ?? ""])
            }
        }
        return error
    }
}


enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }

extension MoyaProvider: ReactiveCompatible { }

public extension Reactive where Base: MoyaProviderType {

    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.failure(error))
                }
            }

            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {

    public func mapJSON(failsOnEmptyData: Bool = true) -> Single<Any> {
        return flatMap { .just(try $0.mapJSON(failsOnEmptyData: failsOnEmptyData)) }
    }

    public func mapString(atKeyPath keyPath: String? = nil) -> Single<String> {
        return flatMap { .just(try $0.mapString(atKeyPath: keyPath)) }
    }

    public func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil, using decoder: JSONDecoder = JSONDecoder(), failsOnEmptyData: Bool = true) -> Single<D> {
        return flatMap { .just(try $0.map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData)) }
    }
}

