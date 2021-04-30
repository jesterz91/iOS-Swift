//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by lee on 2021/05/01.
//

import Foundation

import RxCocoa
import RxSwift

final class DetailViewModel: BaseViewModel {

    private let musicRelay: BehaviorRelay<Music>

    var musicDriver: Driver<Music> {
        return musicRelay.asDriver()
    }

    init(item: Music) {
        self.musicRelay = BehaviorRelay<Music>(value: item)
    }

    func downloadFileFromURL(url: String) -> Single<URL> {

        guard let previewURL = URL(string: url) else { return Single.error(NSError()) }

        return Single<URL>.create { observer in

            let downloadTask = URLSession.shared.downloadTask(with: previewURL) { (url, response, error) in

                if let error = error {
                    print("error: \(error.localizedDescription)")
                    observer(.failure(error))
                }

                if let response = response as? HTTPURLResponse {
                    print("status: \(response.statusCode)")
                }

                guard let fileUrl = url else { return }
                observer(.success(fileUrl))
            }

            downloadTask.resume()
            return Disposables.create()
        }
        
    }
}
