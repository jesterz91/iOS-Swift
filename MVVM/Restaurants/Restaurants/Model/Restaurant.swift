//
//  Restaurant.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let cuisine: Cuisine
}

extension Restaurant {
    var displayText: String {
        "\(name) - \(cuisine.rawValue.capitalized)"
    }
}

enum Cuisine: String, Decodable {
    case english
    case european
    case french
    case indian
    case mexican
}
