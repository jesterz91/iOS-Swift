//
//  SearchViewModel.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import Foundation

import RxCocoa

final class SearchViewModel: BaseViewModel {

    private var page: Int = 0

    private let repoRelay: BehaviorRelay<[Repository]> = BehaviorRelay(value: [])

    var repoDrivder: Driver<[Repository]> {
        repoRelay.asDriver(onErrorJustReturn: [])
    }

    func fetchRepositories(query: String) {
        page += 1

        request(.search(query: query, page: page), model: SearchResponse.self)
            .map { $0.items }
            .asDriver(onErrorJustReturn: [])
            .withLatestFrom(repoDrivder) { new, old in
                return old + new
            }
            .drive(repoRelay)
            .disposed(by: disposeBag)
    }
}
