//
//  BottomSheet.swift
//  BottomSheet
//
//  Created by lee on 2021/06/12.
//

import UIKit

final class BottomSheet {

    static let shared: BottomSheet = .init()

    private var positiveDelegate: (() -> Void)?

    private var negativeDelegate: (() -> Void)?

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()

    private let subtitleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = .zero
        view.font = .systemFont(ofSize: 14)
        view.textColor = .gray
        return view
    }()

    private let confirmButton: UIButton = {
        let view = UIButton()
        view.setTitle("확인", for: .normal)
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.contentEdgeInsets = .init(top: 16, left: 0, bottom: 16, right: 0)
        return view
    }()

    private let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
        view.setTitleColor(.darkGray, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.contentEdgeInsets = .init(top: 16, left: 0, bottom: 16, right: 0)
        return view
    }()

    private let dimView: UIView = {
        let view = UIView()
        // let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.isHidden = true
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.backgroundColor = .white
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = .init(top: 30, leading: 16, bottom: 12, trailing: 16)
        return view
    }()

    private init() {
        confirmButton.addTarget(self, action: #selector(onAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onAction), for: .touchUpInside)
    }

    func show(
        title: String,
        subtitle: String? = nil,
        onPositive: (() -> Void)? = nil,
        onNegative: (() -> Void)? = nil
    ) {
        guard let window = UIApplication.shared.windows.filter(\.isKeyWindow).first else { return }
        
        self.positiveDelegate = onPositive
        self.negativeDelegate = onNegative

        // dim
        dimView.frame = window.frame

        // title
        titleLabel.text = title
        stackView.addArrangedSubview(titleLabel)

        // subtitle
        if subtitle != nil {
            subtitleLabel.text = subtitle
            stackView.addArrangedSubview(subtitleLabel)
            stackView.setCustomSpacing(6, after: titleLabel)
            stackView.setCustomSpacing(30, after: subtitleLabel)
        } else {
            stackView.setCustomSpacing(30, after: titleLabel)
        }

        // yes
        stackView.addArrangedSubview(confirmButton)

        // no
        if negativeDelegate != nil {
            stackView.addArrangedSubview(cancelButton)
        }

        window.addSubview(dimView)
        window.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
        ])

        stackView.transform = CGAffineTransform(translationX: 0, y: stackView.frame.height)

        UIView.animate(withDuration: 0.3) {
            self.dimView.isHidden = false
            self.stackView.transform = .identity
        }
    }
    
    @objc private func onAction(_ sender: UIButton) {
        switch sender {
        case confirmButton:
            positiveDelegate?()
        default:
            negativeDelegate?()
        }
        closeBottomSheet()
    }

    private func closeBottomSheet() {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.stackView.transform = CGAffineTransform(translationX: 0, y: self.stackView.frame.height)
            }, completion: { _ in
                self.dimView.isHidden = true

                self.titleLabel.removeFromSuperview()
                self.subtitleLabel.removeFromSuperview()
                self.confirmButton.removeFromSuperview()
                self.cancelButton.removeFromSuperview()

                self.stackView.removeFromSuperview()
                self.dimView.removeFromSuperview()

                self.positiveDelegate = nil
                self.negativeDelegate = nil
            })
    }
}
