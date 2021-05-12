//
//  Store.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import UIKit

final class Store: ObservableObject {

    @Published var products: [Product]
    
    @Published var orders: [Order] = [] {
        didSet {
            savdeData(at: ordersFilePath, data: orders)
        }
    }

    init() {
        if let productsDataAsset = NSDataAsset(name: "products") {
            self.products = (try? JSONDecoder().decode([Product].self, from: productsDataAsset.data)) ?? []
        } else {
            self.products = []
        }
        self.orders = loadData(at: ordersFilePath)
    }

    func placeOrder(product: Product, quantity: Int) {
        let orderID = Order.orderSequence.next()!
        let order = Order(id: orderID, product: product, quantity: quantity)
        orders.append(order)
        Order.lastOrderID = orderID
    }
    
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        
        products[index].isFavorite.toggle()
    }
}

// MARK: - File Handler
extension Store {

    // [Home Directory]/Library/Application Support/[Bundle ID]/Orders.json
    var ordersFilePath: URL {
        let manager = FileManager.default

        let appSupportDir = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!

        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"

        let appDir = appSupportDir.appendingPathComponent(bundleID, isDirectory: true)

        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir, withIntermediateDirectories: true, attributes: nil)
        }

        return appDir
            .appendingPathComponent("Orders")
            .appendingPathExtension("json")
    }

    func savdeData<T: Encodable>(at path: URL, data: T) {
        do {
            let data: Data = try JSONEncoder().encode(data)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadData<T: Decodable>(at path: URL) -> [T] {
        return (try? JSONDecoder().decode([T].self, from: Data(contentsOf: path))) ?? []
    }
}
