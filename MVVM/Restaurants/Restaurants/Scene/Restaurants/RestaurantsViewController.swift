//
//  RestaurantsViewController.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import UIKit

import RxDataSources

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

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<Cuisine, Restaurant>>(
            configureCell: { dataSource, tableView, indexPath, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                cell.textLabel?.text = element.name
                return cell
            },
            titleForHeaderInSection: { datasource, index in
                return datasource.sectionModels[index].model.rawValue.capitalized
            }
        )

        viewModel.restaurantsDriver
            .map { Dictionary(grouping: $0) { $0.cuisine } } // [Restaurant] -> [Cuisine: Restaurant]
            .map { grouped in
                // [Cuisine: Restaurant] -> [SectionModel<Cuisine, Restaurant>]
                grouped.map { (key, value) in SectionModel<Cuisine, Restaurant>(model: key, items: value) }
            }
            .drive(restaurantsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
