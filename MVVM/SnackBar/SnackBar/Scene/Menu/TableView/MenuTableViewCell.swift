//
//  MenuCell.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

import RxSwift

final class MenuTableViewCell: BaseTableViewCell<Menu> {

    private let plusButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("+", for: .normal)
        return view
    }()

    private let minusButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("-", for: .normal)
        return view
    }()
    
    private let menuLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let countLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemBlue
        view.text = "0개"
        return view
    }()

    private let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func configure() {
        super.configure()
        addSubview(plusButton)
        addSubview(minusButton)
        addSubview(menuLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
    }
    
    override func makeConstraint() {
        super.makeConstraint()
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            minusButton.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor),
            minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            menuLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor),
            menuLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            countLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -20),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override func bind(item: Menu) {
        menuLabel.text = item.name
        countLabel.text = "\(item.count)개"
        priceLabel.text = "x \(item.price)원"
    }

    override func unbind() {
        menuLabel.text = nil
        countLabel.text = nil
        priceLabel.text = nil
    }

    func bind(item: Menu, viewModel: MenuViewModel) {
        bind(item: item)

        let plus = plusButton.rx.tap.map { 1 }
        let minus = minusButton.rx.tap.map { -1 }

        Observable.merge(plus, minus)
            .scan(item.count) { (pre, new) in
                let total = pre + new
                guard (Menu.minimumCount...Menu.maximumCount).contains(total) else { return pre }
                return total
            }
            .asDriver(onErrorJustReturn: 0)
            .map { Menu(name: item.name, price: item.price, count: $0) }
            .drive(onNext: viewModel.updateMenu(item:))
            .disposed(by: disposeBag)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) { /* no-op */ }
}
