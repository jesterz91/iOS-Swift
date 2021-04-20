//
//  SceneDelegate.swift
//  Tweeter
//
//  Created by lee on 2021/04/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let tweetService = TweetService()
        let tweetReactor = TweetReactor(service: tweetService)
        let tweetViewController = TweetViewController(reactor: tweetReactor)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: tweetViewController)
        window?.makeKeyAndVisible()
    }
}
