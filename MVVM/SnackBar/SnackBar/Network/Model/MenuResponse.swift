//
//  MenuResponse.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import Foundation

struct MenuResponse: Decodable {
    let menus: [MenuItem]
}

struct MenuItem: Decodable {
    let name: String
    let price: Int
}
