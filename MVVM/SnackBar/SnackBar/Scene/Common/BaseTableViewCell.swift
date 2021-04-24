//
//  BaseTableViewCell.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

import RxSwift

class BaseTableViewCell<T>: UITableViewCell, Reusable {

    var disposeBag: DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        configure()
        makeConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        unbind()
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    func configure() { /* no-op */ }

    func makeConstraint() { /* no-op */ }
    
    func bind(item: T) { /* no-op */ }

    func unbind() { /* no-op */ }
}
