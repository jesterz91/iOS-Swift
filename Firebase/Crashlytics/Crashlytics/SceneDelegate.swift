//
//  SceneDelegate.swift
//  Crashlytics
//
//  Created by lee on 2021/05/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = ViewController()
            window?.makeKeyAndVisible()
        }
    }

}

