//
//  SearchResponse.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import Foundation

struct SearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Repository: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let itemDescription: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case itemDescription = "description"
        case url
    }
}
