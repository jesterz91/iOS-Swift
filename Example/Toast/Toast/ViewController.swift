//
//  ViewController.swift
//  Toast
//
//  Created by lee on 2021/06/12.
//

import UIKit

final class ViewController: UIViewController {

    private let messageView: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("토스트", for: .normal)
        view.addTarget(self, action: #selector(showToast), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(messageView)
        messageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc private func showToast() {
        Toast.shared.show("* 수정 되었습니다.")
    }
}
