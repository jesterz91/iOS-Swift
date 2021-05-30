//
//  ViewController.swift
//  Crashlytics
//
//  Created by lee on 2021/05/30.
//

import UIKit

final class ViewController: UIViewController {

    private let crashButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("crash", for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(crashButton)
        crashButton.addTarget(self, action: #selector(crashButtonTapped), for: .touchUpInside)
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            crashButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            crashButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc private func crashButtonTapped() {
        fatalError()
    }
}
