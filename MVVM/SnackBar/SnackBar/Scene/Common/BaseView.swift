//
//  BaseView.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() { /* no-op */ }
    
    func makeConstraint() { /* no-op */ }
}
