//
//  ViewController.swift
//  CloudMessage
//
//  Created by lee on 2021/05/27.
//

import UIKit

import FirebaseMessaging

final class ViewController: UIViewController {

    private let label: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.numberOfLines = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tokenButton: UIButton = {
        let view = UIButton()
        view.setTitle("token", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let subscribeButton: UIButton = {
        let view = UIButton()
        view.setTitle("subscribe", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let unsubscribeButton: UIButton = {
        let view = UIButton()
        view.setTitle("unsubscribe", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }

    private func configure() {
        view.backgroundColor = .white

        view.addSubview(label)
        view.addSubview(tokenButton)
        view.addSubview(subscribeButton)
        view.addSubview(unsubscribeButton)

        tokenButton.addTarget(self, action: #selector(requestToken), for: .touchUpInside)
        subscribeButton.addTarget(self, action: #selector(subscribeTopic), for: .touchUpInside)
        unsubscribeButton.addTarget(self, action: #selector(unsubscribeTopic), for: .touchUpInside)
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: tokenButton.topAnchor, constant: -16),

            tokenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tokenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subscribeButton.topAnchor.constraint(equalTo: tokenButton.bottomAnchor, constant: 8),

            unsubscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unsubscribeButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 8),
        ])
    }

    @objc private func requestToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                self.label.text = "Error fetching FCM registration token: \(error)"
                return
            }

            guard let token = token else { return }

            self.label.text = "Remote FCM registration token: \(token)"
        }
    }

    @objc private func subscribeTopic() {
        Messaging.messaging().subscribe(toTopic: "weather") { error in
            if let error = error {
                self.label.text = "subscribe error: \(error)"
                return
            }

            self.label.text = "Subscribed to weather topic"
        }
    }

    @objc private func unsubscribeTopic() {
        Messaging.messaging().unsubscribe(fromTopic: "weather") { error in
            if let error = error {
                self.label.text = "unsubscribe error: \(error)"
                return
            }

            self.label.text = "Unsubscribed to weather topic"
        }
    }
}
