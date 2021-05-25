//
//  SceneDelegate.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let menuService = MenuService()
        let menuViewModel = MenuViewModel(service: menuService)
        let menuViewController = MenuViewController(viewModel: menuViewModel)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: menuViewController)
        window?.makeKeyAndVisible()
    }
}

