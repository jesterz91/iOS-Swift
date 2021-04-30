//
//  BaseReusableView.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import UIKit

class BaseCollectionReusableView<T>: UICollectionReusableView, Reusable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        unbind()
        super.prepareForReuse()
    }

    func configure() { /* no-op */ }

    func makeConstraint() { /* no-op */ }

    func bind(item: T) { /* no-op */ }

    func unbind() { /* no-op */ }
}
