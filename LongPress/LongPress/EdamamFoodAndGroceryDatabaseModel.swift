//
//  EdamamFoodAndGroceryDatabaseModel.swift
//  LongPress
//
//  Created by Dang Duy Cuong on 3/9/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import Foundation

struct EdamamFoodAndGroceryDatabaseModel: Codable {
    var text: String?
    var hints: [Hints]?
}

struct Hints: Codable {
    var food: Food?
}

struct Food: Codable {
    var foodId: String?
    var uri: String?
    var label: String?
//    "nutrients": {
//        "ENERC_KCAL": 52.0,
//        "PROCNT": 0.26,
//        "FAT": 0.17,
//        "CHOCDF": 13.81,
//        "FIBTG": 2.4
//    },
    var category: String?
    var categoryLabel: String?
    var image: String?
}
