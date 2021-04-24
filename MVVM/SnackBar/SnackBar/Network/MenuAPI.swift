//
//  MenuAPI.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import Foundation

import Moya

enum MenuAPI {

    case menus
}

extension MenuAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://firebasestorage.googleapis.com")!
    }

    var path: String {
        switch self {
        case .menus:
            return "/v0/b/rxswiftin4hours.appspot.com/o/fried_menus.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .menus:
            let param = ["alt" : "media", "token" : "42d5cb7e-8ec4-48f9-bf39-3049e796c936"]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
