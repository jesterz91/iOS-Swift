//
//  OrderViewController.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import UIKit

import RxCocoa

final class OrderViewController: BaseViewController<OrderViewModel> {

    private let orderSheet: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = .zero
        view.textAlignment = .right
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        super.configure()
        title = "주문"
        view.addSubview(orderSheet)
    }

    override func makeConstraint() {
        super.makeConstraint()
        NSLayoutConstraint.activate([
            orderSheet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderSheet.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func bind() {
        super.bind()

        Driver.zip(viewModel.totalPriceText, viewModel.orderList)
            .map { $0 + "\n\n" + $1 }
            .drive(orderSheet.rx.text)
            .disposed(by: disposeBag)
    }
}
