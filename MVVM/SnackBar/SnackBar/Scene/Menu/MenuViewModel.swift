//
//  MenuViewModel.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import Foundation

import RxCocoa
import RxSwift

final class MenuViewModel: BaseViewModel {

    private let menuService: MenuService

    private let menuRelay: BehaviorRelay<[Menu]> = BehaviorRelay(value: [])

    private let orderRelay: PublishRelay<[Menu]> = PublishRelay()

    var menuDriver: Driver<[Menu]> {
        menuRelay.asDriver()
    }

    var totalPriceDriver: Driver<Int> {
        menuDriver.map {
            $0.map { $0.price * $0.count }.reduce(0, +)
        }
    }

    var orderSignal: Signal<[Menu]> {
        orderRelay.asSignal()
    }

    init(service: MenuService) {
        self.menuService = service
    }

    func fetchMenus() {
        menuService.request(.menus, type: MenuResponse.self)
            .do(onSubscribe: { [weak self] in self?.loadingRelay.accept(true) })
            .do(onSuccess: { [weak self] _ in self?.loadingRelay.accept(false) })
            .do(onError: { [weak self] _ in self?.loadingRelay.accept(false) })
            .map { $0.menus.map { Menu.fromMenuItem(item: $0) } }
            .subscribe(onSuccess: menuRelay.accept(_:), onError: handleError(_:))
            .disposed(by: disposeBag)
    }

    func updateMenu(item: Menu) {
        Driver.just(item)
            .withLatestFrom(menuDriver) { (new, menus) -> [Menu] in
                return menus.map { origin in
                    guard origin.name == new.name else { return origin }
                    return new
                }
            }
            .drive(menuRelay)
            .disposed(by: disposeBag)
    }

    func submitMenu(items: [Menu]) {
        if items.isEmpty {
            messageRelay.accept(("주문안내", "메뉴를 선택해주세요"))
        } else {
            orderRelay.accept(items)
        }
    }
}
