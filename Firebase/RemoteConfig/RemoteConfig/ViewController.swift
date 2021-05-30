//
//  ViewController.swift
//  RemoteConfig
//
//  Created by lee on 2021/05/30.
//

import UIKit
import FirebaseRemoteConfig

final class ViewController: UIViewController {

    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
        displayMessage()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func displayMessage() {
        let remoteConfig = RemoteConfig.remoteConfig()

        let message = remoteConfig.configValue(forKey: "welcome_message").stringValue ?? ""
        welcomeLabel.text = message
        /**
         {
            "id":1,
            "albumId":1,
            "title":"accusamus beatae ad facilis cum similique qui sunt",
            "url":"https://via.placeholder.com/600/92c952",
            "thumbnailUrl":"https://via.placeholder.com/150/92c952"
         }
         */
        let data = remoteConfig.configValue(forKey: "photo")

//        if let dict = data.jsonValue as? [String: Any] { }

        if let photo = try? JSONDecoder().decode(Photo.self, from: data.dataValue) {
            print(photo.title)
            print(photo.url)
        }
    }
}


