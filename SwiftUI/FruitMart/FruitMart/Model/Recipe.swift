//
//  Recipe.swift
//  FruitMart
//
//  Created by lee on 2021/05/11.
//

import UIKit

struct Recipe {
    let name: String
    let imageName: String

    static func samples() -> [Recipe] {
        guard let recipesDataAsset = NSDataAsset(name: "recipes") else { return [] }

        return (try? JSONDecoder().decode([Recipe].self, from: recipesDataAsset.data)) ?? []
    }
}

extension Recipe: Decodable {

    enum CodingKeys: String, CodingKey {
        case name
        case imageName
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.name = (try? values.decode(String.self, forKey: .name)) ?? ""
        self.imageName = (try? values.decode(String.self, forKey: .imageName)) ?? ""
    }
}
