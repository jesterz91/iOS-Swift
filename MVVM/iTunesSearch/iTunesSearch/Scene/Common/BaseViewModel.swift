//
//  BaseViewModel.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

import RxSwift
import RxCocoa

class BaseViewModel {

    var disposeBag: DisposeBag = DisposeBag()

    func initiate() { /* no-op */ }

    deinit {
        disposeBag = DisposeBag()
    }
}
