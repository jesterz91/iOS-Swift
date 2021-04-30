//
//  ApiService.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

import Alamofire
import RxSwift

final class ApiService {

    static let shared = ApiService()

    private init() { /* no-op */ }

    func request(query: String) -> Single<SearchResponse> {

        return Single.create { observer in
            AF.request(
                "https://itunes.apple.com/search",
                method: .get,
                parameters: ["term":query, "media":"music"]
            )
            .validate()
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    observer(.success(searchResponse))
                case .failure(let error):
                    print("통신 에러발생")
                    dump(error)
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
