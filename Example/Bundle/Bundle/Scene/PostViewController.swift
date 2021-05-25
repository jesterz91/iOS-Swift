//
//  PostViewController.swift
//  Bundle
//
//  Created by lee on 2021/05/26.
//

import UIKit

import RxCocoa
import RxSwift

final class PostViewController: BaseViewController {

    private let postTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()

    override func configure() {
        view.backgroundColor = .white
        view.addSubview(postTableView)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    override func bind() {
        guard let postData = NSDataAsset(name: "post")?.data else { return }

        Observable.just(postData)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .asDriver(onErrorJustReturn: [])
            .drive(postTableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self))) { row, item , cell in
                cell.textLabel?.text = item.body
                cell.textLabel?.numberOfLines = .zero
            }
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI

struct PostViewController_Previews: PreviewProvider {

    static var previews: some View {
        return ViewControllerRepresentable(target: PostViewController())
    }
}
#endif
