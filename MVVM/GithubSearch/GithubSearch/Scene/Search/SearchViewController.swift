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

    var isScrollingDown: Bool = false

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
            .drive(repoTableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self), cellType: UITableViewCell.self)) { _, item, cell in
                cell.textLabel?.numberOfLines = .zero
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.text = item.name + "\n" + item.itemDescription
            }
            .disposed(by: disposeBag)

        // 이전 좌표와 새 좌표를 비교하여 스크롤 여부 판단
        repoTableView.rx.contentOffset
            .scan((CGPoint.zero, CGPoint.zero)) { (tuple, newPoint) -> (CGPoint, CGPoint) in
                let prevPoint = tuple.0
                return (prevPoint, newPoint)
            }
            .map { (old: CGPoint, new: CGPoint) in
                return old.y < new.y
            }
            .distinctUntilChanged()
            .bind(to: self.rx.isScrollingDown)
            .disposed(by: self.disposeBag)

        // loadMore 이벤트 처리
        repoTableView.rx.willDisplayCell
            .filter { [weak self] (cell, indexPath) -> Bool in
                guard let self = self, self.isScrollingDown else { return false }
                return indexPath.row == self.repoTableView.numberOfRows(inSection: 0) - Search.loadMoreDistance
            }
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.fetchRepositories(query: Search.query)
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: SearchViewController {

    var isScrollingDown: Binder<Bool> {
        return Binder(self.base) { vc, result in
            vc.isScrollingDown = result
        }
    }
}
