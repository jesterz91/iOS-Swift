//
//  MenuTableView.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

import RxSwift
import RxCocoa

final class MenuTableView: BaseTableView {

    private enum Size {
        static let heightForHeader: CGFloat = 50
        static let heightForFooter: CGFloat = 100
    }

    override func configure() {
        super.configure()
        allowsSelection = false

        tableHeaderView = MenuTableHeaderView()
        tableHeaderView?.frame.size = CGSize(width: frame.width, height: Size.heightForHeader)

        tableFooterView = MenuTableFooterView()
        tableFooterView?.frame.size = CGSize(width: frame.width, height: Size.heightForFooter)

        register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)

        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension
    }
}

extension Reactive where Base: MenuTableView {
    
    var totalPrice: Binder<Int> {
        return Binder(self.base) { view, price in
            if let footer = view.tableFooterView as? MenuTableFooterView {
                footer.setPrice(price)
            }
        }
    }
}
