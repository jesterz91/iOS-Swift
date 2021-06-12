//
//  Toast.swift
//  Toast
//
//  Created by lee on 2021/06/12.
//

import UIKit

final class Toast {

    static let shared: Toast = .init()

    private let messageView: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.alpha = 0
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 12)
        view.contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        return view
    }()

    private init() { /* no-op */ }

    func show(_ message: String) {
        guard let window = UIApplication.shared.windows.filter(\.isKeyWindow).first else { return }
        window.addSubview(messageView)

        NSLayoutConstraint.activate([
            messageView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            messageView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -50)
        ])

        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.messageView.alpha = 1
                self.messageView.setTitle(message, for: .normal)
            },
            completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.messageView.alpha = 0
                    self.messageView.titleLabel?.text = nil
                    self.messageView.removeFromSuperview()
                }
            })
    }
}
