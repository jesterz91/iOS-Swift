//
//  SearchCell.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

import Kingfisher
import Then

final class MusicCollectionViewCell: BaseCollectionViewCell<Music> {

    private let albumImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
    }

    private let artistLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13)
        $0.textAlignment = .center
    }

    override func configure() {
        backgroundColor = .blue.withAlphaComponent(0.4)
        contentView.addSubview(albumImageView)
        contentView.addSubview(artistLabel)
    }

    override func makeConstraint() {
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            albumImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            albumImageView.widthAnchor.constraint(equalToConstant: 75),
            albumImageView.heightAnchor.constraint(equalToConstant: 75),

            artistLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10),
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    override func bind(item: Music) {
        albumImageView.kf.setImage(with: URL(string: item.artworkUrl100))
        artistLabel.text = item.trackName
    }

    override func unbind() {
        albumImageView.image = nil
        artistLabel.text = nil
    }
}
