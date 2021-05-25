//
//  Album.swift
//  Bundle
//
//  Created by lee on 2021/05/26.
//

import Foundation

struct Album: Decodable {
    let userID: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

