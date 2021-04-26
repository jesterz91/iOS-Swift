//
//  BaseViewModel.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import Foundation

import RxSwift
import Moya

class BaseViewModel {

    var disposeBag = DisposeBag()

    private let provider = MoyaProvider<GithubAPI>()

    func request<D: Decodable>(_ target: GithubAPI, model: D.Type) -> Single<D> {
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(model)
    }

    func handleError(_ error: Error) {
        print(error.localizedDescription)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}
