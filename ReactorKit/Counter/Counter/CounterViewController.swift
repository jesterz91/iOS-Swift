//
//  ViewController.swift
//  Counter
//
//  Created by lee on 2021/04/16.
//

import UIKit

import ReactorKit
import RxCocoa

final class CounterViewController: UIViewController {

    var disposeBag: DisposeBag = DisposeBag()

    private let countLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(reactor: CounterReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(countLabel)
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            plusButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 30),
            
            minusButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -30),
            
            indicator.centerXAnchor.constraint(equalTo: countLabel.centerXAnchor),
            indicator.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 30)
        ])
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension CounterViewController: View {

    func bind(reactor: CounterReactor) {
        // Action
        plusButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        minusButton.rx.tap
            .map { CounterReactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
