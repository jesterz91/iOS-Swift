//
//  AppCoordinator.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let service: RestaurantServiceProtocol = RestaurantService()
        let viewModel = RestaurantsViewModel(service: service)
        let viewController = RestaurantsViewController(viewModel: viewModel)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
