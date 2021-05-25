//
//  BaseViewController.swift
//  Bundle
//
//  Created by lee on 2021/05/26.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

    var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
        bind()
    }

    func configure() { /* no-op */ }

    func makeConstraint() { /* no-op */ }

    func bind() { /* no-op */ }
    
    deinit {
        disposeBag = .init()
    }
}
