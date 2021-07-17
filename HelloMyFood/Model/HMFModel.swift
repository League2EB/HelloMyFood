//
//  HMFModel.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

import ObjectMapper

enum FoodCategory: String, CaseIterable {
    case biryani = "biryani"
    case burger = "burger"
    case butterChicken = "butter-chicken"
    case dessert = "dessert"
    case dosa = "dosa"
    case idly = "idly"
    case pasta = "pasta"
    case pizza = "pizza"
    case rice = "rice"
    case samosa = "samosa"
}

class HMFFoodData: Mappable {

    var image: String = ""

    required init?(map: Map) { }

    func mapping(map: Map) {
        image <- map["image"]
    }
}

