//
//  Photo.swift
//  RemoteConfig
//
//  Created by lee on 2021/05/31.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let albumID: Int
    let title: String
    let url: String
    let thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
