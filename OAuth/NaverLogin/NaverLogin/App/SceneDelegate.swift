//
//  SceneDelegate.swift
//  NaverLogin
//
//  Created by lee on 2021/02/20.
//

import UIKit

import NaverThirdPartyLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        NaverThirdPartyLoginConnection
            .getSharedInstance()?
            .receiveAccessToken(URLContexts.first?.url)
    }
}

