//
//  Store.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import UIKit

final class Store: ObservableObject {

    @Published var products: [Product]
    
    @Published var orders: [Order] = []

    init() {
        if let productsDataAsset = NSDataAsset(name: "products") {
            self.products = (try? JSONDecoder().decode([Product].self, from: productsDataAsset.data)) ?? []
        } else {
            self.products = []
        }
    }

    func placeOrder(product: Product, quantity: Int) {
        let orderID = Order.orderSequence.next()!
        let order = Order(id: orderID, product: product, quantity: quantity)
        orders.append(order)
    }
}

extension Store {
    
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        
        products[index].isFavorite.toggle()
    }
}
