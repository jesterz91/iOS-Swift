//
//  ViewController.swift
//  NaverLogin
//
//  Created by lee on 2021/02/20.
//

import UIKit

import NaverThirdPartyLogin

final class ViewController: UIViewController {
    
    private lazy var naverLoginConnection: NaverThirdPartyLoginConnection? = {
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        instance?.delegate = self
        return instance
    }()
    
    private lazy var loginButton: UIImageView = {
        let view = UIImageView(image: .naver_login)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(login)))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "네이버 로그인"
        self.view.backgroundColor = .white
        self.view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        logout()
//         unlink()
    }

    @objc private func login() {
        naverLoginConnection?.requestThirdPartyLogin()
    }

    private func logout() {
        naverLoginConnection?.resetToken()
    }

    private func unlink() {
        naverLoginConnection?.requestDeleteToken() // 연동해제
    }

    private func requestUserInfo() {
        guard let isValidAccessToken = naverLoginConnection?.isValidAccessTokenExpireTimeNow() else { return }

        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = naverLoginConnection?.tokenType else { return }
        guard let accessToken = naverLoginConnection?.accessToken else { return }
        guard let naverOpenApiUrl = URL(string: "https://openapi.naver.com/v1/nid/me") else { return }

        var request = URLRequest(url: naverOpenApiUrl)
        request.httpMethod = "POST"
        request.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("rquest error \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                let httpResponse = response as! HTTPURLResponse
                print("no data \(httpResponse.statusCode)")
                return
            }

//             dump(String(data: data, encoding: .utf8))

            do {
                let user = try JSONDecoder().decode(NaverLoginResponse.self, from: data)
                dump(user)
            } catch {
                print("eroor \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인 성공 시 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        self.requestUserInfo()
    }

    // 에러
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("oauth20Connection \(error.localizedDescription)")
    }

    // 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
    }

    // 네아로 연동 해제시 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        print("oauth20ConnectionDidFinishDeleteToken")
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
