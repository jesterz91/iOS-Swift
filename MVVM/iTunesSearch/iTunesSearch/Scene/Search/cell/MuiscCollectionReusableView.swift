//
//  SearchHeaderView.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

import Then

final class MuiscCollectionReusableView: BaseCollectionReusableView<String> {
    
    
    private let artistLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    override func configure() {
        addSubview(artistLabel)
    }
    
    override func makeConstraint() {
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            artistLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    override func bind(item: String) {
        artistLabel.text = item
        backgroundColor = .systemTeal
    }
    
    override func unbind() {
        artistLabel.text = nil
        backgroundColor = nil
    }
}
