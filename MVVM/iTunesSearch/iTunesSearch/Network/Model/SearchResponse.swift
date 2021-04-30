//
//  SearchResponse.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Decodable {
    let artistID: Int
    let artistName: String
    let artistViewURL: String

    let trackID: Int
    let trackName: String
    let trackCensoredName: String
    let trackViewURL: String

    let previewURL: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case artistName
        case artistViewURL = "artistViewUrl"

        case trackID = "trackId"
        case trackName
        case trackCensoredName
        case trackViewURL = "trackViewUrl"

        case previewURL = "previewUrl"
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100
    }
}
