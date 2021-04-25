//
//  BaseViewModel.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import Foundation

import RxSwift

class BaseViewModel {

    var disposeBag: DisposeBag = DisposeBag()

    func handleError(_ error: Error) {
        print(error.localizedDescription)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}
