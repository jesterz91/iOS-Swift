//
//  RestaurantsViewController.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import UIKit

final class RestaurantsViewController: BaseViewController<RestaurantsViewModel> {

    private let restaurantsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        view.tableFooterView = UIView()
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRestaurants()
    }

    override func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(restaurantsTableView)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            restaurantsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            restaurantsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            restaurantsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            restaurantsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func bind() {

        viewModel.titleDriver
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.restaurantsDriver
            .drive(restaurantsTableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self), cellType: UITableViewCell.self)) { _, item, cell in
                cell.textLabel?.text = item.displayText
            }
            .disposed(by: disposeBag)
    }
}
