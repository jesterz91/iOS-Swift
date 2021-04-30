//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources
import Then

final class SearchViewController: BaseViewController<SearchViewModel> {

    private let searchBar = UISearchBar().then {
        $0.placeholder = "검색"
    }

    private let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 7
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        view.register(MuiscCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MuiscCollectionReusableView.identifier)
        return view
    }()

    override func configure() {
        navigationItem.titleView = searchBar
        view.backgroundColor = .white
        view.addSubview(searchCollectionView)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            searchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func bind() {

        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.queryRelay)
            .disposed(by: disposeBag)

        searchCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        searchCollectionView.rx.modelSelected(Music.self)
            .asDriver()
            .drive(onNext: { [weak self] music in
                let vc = DetailViewController(viewModel: DetailViewModel(item: music))
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)

        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Music>>(
            configureCell: configureCell(_:_:_:_:),
            configureSupplementaryView: configureSupplementaryView(_:_:_:_:)
        )

        viewModel.resultDriver
            .map { Dictionary(grouping: $0) { $0.artistName } }
            .map { $0.map { key, value in SectionModel<String, Music>(model: key, items: value) } }
            .drive(searchCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    private func configureCell(
        _ dataSoucrce: CollectionViewSectionedDataSource<SectionModel<String, Music>>,
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ model: Music
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath)

        if let cell = cell as? MusicCollectionViewCell {
            cell.bind(item: model)
        }
        return cell
    }

    private func configureSupplementaryView(
        _ dataSoucrce: CollectionViewSectionedDataSource<SectionModel<String, Music>>,
        _ collectionView: UICollectionView,
        _ kind: String,
        _ indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:

            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MuiscCollectionReusableView.identifier, for: indexPath)

            if let view = view as? MuiscCollectionReusableView {
                let sectionModel: SectionModel<String, Music> = dataSoucrce[indexPath.section]
                let section: String = sectionModel.model
                // let items: [Music] = sectionModel.items
                view.bind(item: section)
            }
            return view
        default:
            return UICollectionReusableView()
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let column: CGFloat = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let remainWidth = collectionView.bounds.width
            - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
            - flowLayout.minimumInteritemSpacing * (column - 1)

        let width = remainWidth / column

        return CGSize(width: width, height: width)
    }
}
