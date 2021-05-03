//
//  Store.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import UIKit

final class Store {

    static var products: [Product] {
        guard let productsDataAsset = NSDataAsset(name: "products") else { return [] }
        
        return (try? JSONDecoder().decode([Product].self, from: productsDataAsset.data)) ?? []
    }
}
