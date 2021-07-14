//
//  HMFModel.swift
//  HelloMyFood
//
//  Created by Lazy on 2021/7/14.
//

enum FoodCategory: String {
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

struct FoodData: Decodable {
    var image: String
}

