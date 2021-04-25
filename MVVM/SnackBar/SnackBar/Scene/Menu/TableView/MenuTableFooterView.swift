//
//  MenuTableFooterView.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import UIKit

final class MenuTableFooterView: BaseView {

    private let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "0 원"
        view.font = .systemFont(ofSize: 40)
        return view
    }()
    
    override func configure() {
        backgroundColor = .systemGreen
        addSubview(priceLabel)
    }
    
    override func makeConstraint() {
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setPrice(_ price: Int) {
        priceLabel.text = "\(price) 원"
    }
}
