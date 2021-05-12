//
//  Product.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import Foundation

struct Product: Identifiable {
    let id: UUID = UUID()
    let name: String
    let imageName: String
    let price: Int
    let description: String
    var isFavorite: Bool
}

extension Product: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case imageName
        case price
        case description
        case isFavorite
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.name = (try? values.decode(String.self, forKey: .name)) ?? ""
        self.imageName = (try? values.decode(String.self, forKey: .imageName)) ?? ""
        self.price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        self.description = (try? values.decode(String.self, forKey: .description)) ?? ""
        self.isFavorite = (try? values.decode(Bool.self, forKey: .isFavorite)) ?? false
    }
}

// 구조체에서는 모든 저장 프로퍼티가 Equatable을 준수하면
// 컴파일러가 자동으로 합성해 주므로 생략가능
extension Product: Equatable {}
