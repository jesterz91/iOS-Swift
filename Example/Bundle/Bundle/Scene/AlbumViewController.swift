//
//  ContentView.swift
//  Bundle
//
//  Created by lee on 2021/05/26.
//

import UIKit

import RxCocoa
import RxSwift

final class AlbumViewController: BaseViewController {

    private let albums = Bundle.main.decode([Album].self, from: "albums.json")

    private let albumTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        return view
    }()

    override func configure() {
        view.backgroundColor = .white
        view.addSubview(albumTableView)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            albumTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            albumTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            albumTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            albumTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    override func bind() {
        Observable.just(albums)
            .asDriver(onErrorJustReturn: [])
            .drive(albumTableView.rx.items(cellIdentifier: String(describing: UITableViewCell.self))) { row, item , cell in
                cell.textLabel?.text = item.title
                cell.textLabel?.numberOfLines = .zero
            }
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI

struct AlbumViewController_Previews: PreviewProvider {

    static var previews: some View {
        return ViewControllerRepresentable(target: AlbumViewController())
    }
}
#endif
