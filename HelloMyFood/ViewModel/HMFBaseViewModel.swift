//
//  HMFBaseViewModel.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/16.
//

import RxSwift
import RxCocoa

class HMFBaseViewModel {

    let bag: DisposeBag = DisposeBag()

    let api: HMFAPI = HMFAPI()
}
