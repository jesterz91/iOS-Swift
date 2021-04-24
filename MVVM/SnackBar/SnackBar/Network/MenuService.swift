//
//  MenuService.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import Foundation

import Moya
import RxSwift

final class MenuService {

    private let menuProvider: MoyaProvider<MenuAPI> = {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        #endif
        return MoyaProvider<MenuAPI>(plugins: plugins)
    }()

    private let scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .default)

    func request<D: Decodable>(_ target: MenuAPI, type: D.Type) -> Single<D> {
        return menuProvider.rx.request(target)
            .map(type)
            .delay(.seconds(1), scheduler: scheduler)
    }
}
