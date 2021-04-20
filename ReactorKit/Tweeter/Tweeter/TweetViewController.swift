//
//  ViewController.swift
//  Tweeter
//
//  Created by lee on 2021/04/17.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class TweetViewController: UIViewController {

    var disposeBag: DisposeBag = DisposeBag()

    private let tweetTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.returnKeyType = .done
        return view
    }()

    private let tweetRemainCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tweetSubmitButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "보내기", style: .plain, target: nil, action: nil)
        return view
    }()

    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        return view
    }()

    init(reactor: TweetReactor) {
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
        title = "Tweeter"
        navigationItem.rightBarButtonItem = tweetSubmitButton
        tweetTextView.delegate = self

        view.backgroundColor = .white
        view.addSubview(tweetTextView)
        view.addSubview(tweetRemainCountLabel)
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            tweetTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tweetTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tweetTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tweetTextView.bottomAnchor.constraint(equalTo: tweetRemainCountLabel.topAnchor),
            
            tweetRemainCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tweetRemainCountLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),

            indicator.topAnchor.constraint(equalTo: view.topAnchor),
            indicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            indicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func showMessage(_ message: String) {
        guard !message.isEmpty else { return }

        let alert = UIAlertController(title: "Tweet", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.tweetTextView.text = ""
        }
        alert.addAction(action)

        present(alert, animated: false)
    }

    deinit {
        disposeBag = DisposeBag()
    }
}

extension TweetViewController: View {

    func bind(reactor: TweetReactor) {
        // Action
        tweetTextView.rx.text.orEmpty
            .map { TweetReactor.Action.updateText($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        tweetSubmitButton.rx.tap
            .map { TweetReactor.Action.submit }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.text }
            .distinctUntilChanged()
            .bind(to: tweetTextView.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.remainTextCount }
            .distinctUntilChanged()
            .map { "나머지 \($0) 문자" }
            .bind(to: tweetRemainCountLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isTweetButtonEnable }
            .distinctUntilChanged()
            .bind(to: tweetSubmitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: disposeBag)

        // signal
        reactor.messageSignal
            .emit(onNext: showMessage(_:))
            .disposed(by: disposeBag)
    }
}

extension TweetViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""

        guard let strRange = Range(range, in: currentText) else { return false }

        let newText = currentText.replacingCharacters(in: strRange, with: text)

        return newText.count <= TweetService.maxLength
    }
}
