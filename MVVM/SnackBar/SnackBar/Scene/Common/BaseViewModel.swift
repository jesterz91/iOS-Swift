//
//  BaseViewModel.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import Foundation

import RxSwift
import RxCocoa

class BaseViewModel {

    var disposeBag: DisposeBag = DisposeBag()

    let loadingRelay: PublishRelay<Bool> = PublishRelay()

    var loadingSignal: Signal<Bool> {
        loadingRelay.asSignal()
    }

    let messageRelay: PublishRelay<(String, String)> = PublishRelay()

    var messageSignal: Signal<(String, String)> {
        messageRelay.asSignal()
    }

    func handleError(_ error: Error) {
        print(error.localizedDescription)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}
