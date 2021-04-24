//
//  MenuViewController.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

import RxSwift

final class MenuViewController: BaseViewController<MenuViewModel> {

    private let menuTableView: MenuTableView = {
        let view = MenuTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let orderButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.setTitle("주문", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 20)
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMenus()
    }

    override func configure() {
        super.configure()
        title = "메뉴"
        view.backgroundColor = .white
        view.addSubview(menuTableView)
        view.addSubview(orderButton)
    }

    override func makeConstraint() {
        super.makeConstraint()
        NSLayoutConstraint.activate([
            menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor),

            orderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    override func bind() {
        super.bind()

        viewModel.menuDriver
            .drive(menuTableView.rx.items(cellIdentifier: MenuTableViewCell.identifier, cellType: MenuTableViewCell.self)) { [weak self] _, item, cell in
                guard let self = self else { return }
                cell.bind(item: item, viewModel: self.viewModel)
            }
            .disposed(by: disposeBag)

        viewModel.totalPriceDriver
            .drive(menuTableView.rx.totalPrice)
            .disposed(by: disposeBag)

        viewModel.orderSignal
            .emit(onNext: { [weak self] menus in
                let vc = OrderViewController(viewModel: OrderViewModel(menus: menus))
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        orderButton.rx.tap
            .asDriver(onErrorJustReturn: ())
            .withLatestFrom(viewModel.menuDriver) { _, menus in
                menus.filter { $0.count > 0 }
            }
            .drive(onNext: viewModel.submitMenu(items:))
            .disposed(by: disposeBag)
    }
}
