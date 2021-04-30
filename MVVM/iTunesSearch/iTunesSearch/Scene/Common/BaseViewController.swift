//
//  BaseViewController.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController<VM: BaseViewModel>: UIViewController, UIGestureRecognizerDelegate {

    var disposeBag: DisposeBag = DisposeBag()

    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
        bind()

        viewModel.initiate()
    }

    func configure() { /* no-op */ }

    func makeConstraint() { /* no-op */ }

    func bind() { /* no-op */ }

    deinit {
        disposeBag = DisposeBag()
    }
}
