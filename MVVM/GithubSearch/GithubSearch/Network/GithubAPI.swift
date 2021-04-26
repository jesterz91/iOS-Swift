//
//  GithubAPI.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import Foundation

import Moya

enum GithubAPI {

    case search(query: String, page: Int)
}

extension GithubAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        return "/search/repositories"
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case .search(let query, let page):
            let param: [String: Any] = [
                "q": query,
                "page": page,
                "per_page": 30,
                "sort": "stars"
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
