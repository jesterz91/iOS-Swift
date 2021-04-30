//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

import RxCocoa

final class SearchViewModel: BaseViewModel {

    let queryRelay: PublishRelay<String> = PublishRelay()

    private let resultRelay: BehaviorRelay<[Music]> = BehaviorRelay(value: [])

    var resultDriver: Driver<[Music]> {
        resultRelay.asDriver()
    }

    override func initiate() {
        queryRelay
            .flatMap { ApiService.shared.request(query: $0) }
            .map { $0.results }
            .catchAndReturn([])
            .bind(to: resultRelay)
            .disposed(by: disposeBag)
    }
}
