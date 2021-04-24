//
//  OrderViewModel.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import Foundation

import RxCocoa
import RxSwift

final class OrderViewModel: BaseViewModel {

    private let menus: Driver<[Menu]>

    let totalPriceText: Driver<String>

    let orderList: Driver<String>
    
    init(menus: [Menu]) {
        self.menus = Observable.just(menus).asDriver(onErrorJustReturn: [])

        self.totalPriceText = self.menus.map {
            "주문메뉴 확인 총 \($0.map { $0.price * $0.count }.reduce(0, +)) 원"
        }

        self.orderList = self.menus.map {
            $0.map { "\($0.name) \($0.count)개 \($0.price * $0.count)원\n" }.joined()
        }
    }
}
