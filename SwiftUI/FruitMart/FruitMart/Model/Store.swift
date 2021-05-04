//
//  Store.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import UIKit

final class Store: ObservableObject {

    @Published var products: [Product]
    
    init() {
        if let productsDataAsset = NSDataAsset(name: "products") {
            self.products = (try? JSONDecoder().decode([Product].self, from: productsDataAsset.data)) ?? []
        } else {
            self.products = []
        }
    }
}

extension Store {
    
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        
        products[index].isFavorite.toggle()
    }
}
