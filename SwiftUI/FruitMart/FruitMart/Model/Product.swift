//
//  Product.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import Foundation

struct Product: Decodable {
    let name: String
    let imageName: String
    let price: Int
    let description: String
    let isFavorite: Bool
}
