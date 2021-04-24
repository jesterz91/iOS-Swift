//
//  BaseViewController.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
//

import UIKit

import RxCocoa
import RxSwift

class BaseViewController<VM: BaseViewModel>: UIViewController, UIGestureRecognizerDelegate {

    var disposeBag: DisposeBag = DisposeBag()

    let viewModel: VM

    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        return view
    }()

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
    }

    func configure() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .white
        view.addSubview(indicator)
    }

    func makeConstraint() {
        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicator.topAnchor.constraint(equalTo: view.topAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func bind() {
        view.bringSubviewToFront(indicator)

        viewModel.loadingSignal
            .emit(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.messageSignal
            .emit(onNext: { [weak self] (title, message) in
                self?.showAlert(title, message)
            })
            .disposed(by: disposeBag)
    }

    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}
