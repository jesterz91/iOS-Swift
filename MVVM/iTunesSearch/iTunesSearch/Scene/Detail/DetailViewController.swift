//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by lee on 2021/05/01.
//

import AVFoundation
import UIKit

import Kingfisher
import Then
import RxCocoa

final class DetailViewController: BaseViewController<DetailViewModel> {

    private var player: AVAudioPlayer?

    private let albumImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }

    private let playButton = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("플레이", for: .normal)
        $0.setTitleColor(.red, for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.stop()
        player = nil
    }

    override func configure() {
        viewModel.musicDriver
            .map { $0.artistName }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        view.backgroundColor = .white
        view.addSubview(albumImageView)
        view.addSubview(playButton)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            albumImageView.widthAnchor.constraint(equalToConstant: 250),
            albumImageView.heightAnchor.constraint(equalToConstant: 250),
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            playButton.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func bind() {

        viewModel.musicDriver
            .map { $0.artworkUrl100 }
            .drive(onNext: { [weak self] in
                self?.albumImageView.kf.setImage(with: URL(string: $0))
            })
            .disposed(by: disposeBag)

        playButton.rx.tap
            .withLatestFrom(viewModel.musicDriver)
            .flatMap { self.viewModel.downloadFileFromURL(url: $0.previewURL) }
            .subscribe(onNext: play(url:))
            .disposed(by: disposeBag)
    }

    private func play(url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = 1.0
            player?.prepareToPlay()
            player?.play()
            print("playing \(url)")
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
