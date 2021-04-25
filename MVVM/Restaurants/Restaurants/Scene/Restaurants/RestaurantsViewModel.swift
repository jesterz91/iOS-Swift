//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import Foundation

import RxCocoa
import RxSwift

final class RestaurantsViewModel: BaseViewModel {

    private let service: RestaurantServiceProtocol

    private let restaurantsRelay: BehaviorRelay<[Restaurant]> = BehaviorRelay(value: [])

    var restaurantsDriver: Driver<[Restaurant]> {
        restaurantsRelay.asDriver()
    }

    let titleDriver: Driver<String> = Driver.just("Restaurants")

    init(service: RestaurantServiceProtocol) {
        self.service = service
    }

    func fetchRestaurants() {
        service.fetchRestaurants()
            .subscribe(onSuccess: restaurantsRelay.accept(_:), onFailure: handleError(_:))
            .disposed(by: disposeBag)
    }
}
