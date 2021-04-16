//
//  ViewController.swift
//  KakaoLogin
//
//  Created by lee on 2021/02/20.
//

import UIKit

import RxSwift
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

final class ViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private lazy var loginButton: UIImageView = {
        let view = UIImageView(image: .kakao_login)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "카카오 로그인"
        self.view.backgroundColor = .white
        self.view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc private func login() {
        // 카카오톡 설치 여부 확인
        if (AuthApi.isKakaoTalkLoginAvailable()) {
            loginWithKakaoTalk() // 카카오톡을 실행하여 로그인을 진행
        } else {
            loginWithKakaoAccount() // 기본 웹 브라우저를 사용하여 로그인을 진행
        }
    }
    
    private func loginWithKakaoTalk() {
        AuthApi.shared.rx.loginWithKakaoTalk()
            .subscribe(onNext:{ (oauthToken) in
                print("loginWithKakaoTalk() success.")
                
                self.requestUserInfo()
                _ = oauthToken
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func loginWithKakaoAccount() {
        AuthApi.shared.rx.loginWithKakaoAccount()
            .subscribe(onNext:{ (oauthToken) in
                print("loginWithKakaoAccount() success.")
                
                self.requestUserInfo()
                _ = oauthToken
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func requestUserInfo() {
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ user in
                dump(user)
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func logout() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted:{
                print("logout() success.")
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func unlink() {
        UserApi.shared.rx.unlink()
            .subscribe(onCompleted:{
                print("unlink() success.")
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

#if DEBUG
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { /* no-op */ }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
#endif
