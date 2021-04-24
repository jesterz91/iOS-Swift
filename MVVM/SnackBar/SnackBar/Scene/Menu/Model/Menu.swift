//
//  Menu.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import Foundation

struct Menu {
    let name: String
    let price: Int
    let count: Int
}

extension Menu {
    
    static let minimumCount = 0

    static let maximumCount = 10

    static func fromMenuItem(item: MenuItem) -> Menu {
        return Menu(name: item.name, price: item.price, count: 0)
    }
}
