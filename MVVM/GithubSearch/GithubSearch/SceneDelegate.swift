//
//  SceneDelegate.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: SearchViewController(viewModel: SearchViewModel()))
        window?.makeKeyAndVisible()
    }
}
