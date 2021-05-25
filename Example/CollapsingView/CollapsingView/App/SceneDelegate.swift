//
//  SceneDelegate.swift
//  CollapsingView
//
//  Created by lee on 2021/05/26.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = CollapsingViewController()
            window?.makeKeyAndVisible()
        }
    }
}

