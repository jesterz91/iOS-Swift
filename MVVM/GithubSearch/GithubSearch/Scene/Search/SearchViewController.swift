//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by lee on 2021/04/26.
//

import UIKit

import RxCocoa
import RxSwift

final class SearchViewController: BaseViewController<SearchViewModel> {

    private enum Search {
        static let query: String = "스위프트"
        static let loadMoreDistance: Int = 4
    }

    private let repoTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsSelection = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRepositories(query: Search.query)
    }

    override func configure() {
        self.title = "search"
        view.backgroundColor = .white
        view.addSubview(repoTableView)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            repoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            repoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            repoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            repoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func bind() {

        viewModel.repoDrivder
            .drive(repoTableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self))) { _, item, cell in
                cell.textLabel?.numberOfLines = .zero
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.text = item.name + "\n" + item.itemDescription
            }
            .disposed(by: disposeBag)

        // Pagination
        repoTableView.rx.prefetchRows
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] indexPaths in
                guard let self = self else { return }

                let itemCount = self.repoTableView.numberOfRows(inSection: 0)

                indexPaths
                    .first { $0.row == itemCount - Search.loadMoreDistance }
                    .map { _ in self.viewModel.fetchRepositories(query: Search.query) }
            })
            .disposed(by: disposeBag)
    }
}
