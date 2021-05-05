//
//  SceneDelegate.swift
//  FruitMart
//
//  Created by lee on 2021/05/02.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Use a UIHostingController as window root view controller.
        guard let windowScene = scene as? UIWindowScene else { return }

        configureAppearance()

        let rootView = HomeView().environmentObject(Store()).accentColor(.primary)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIHostingController(rootView: rootView)
        window?.makeKeyAndVisible()
    }

    private func configureAppearance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.peach
        ]
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.peach
        ]
    }
}

