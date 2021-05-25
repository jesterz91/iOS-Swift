//
//  Post.swift
//  Bundle
//
//  Created by lee on 2021/05/26.
//

import Foundation

struct Post: Decodable {
    let userID: Int
    let id: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

