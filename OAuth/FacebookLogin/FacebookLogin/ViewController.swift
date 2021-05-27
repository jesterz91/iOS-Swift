//
//  ViewController.swift
//  FacebookLogin
//
//  Created by lee on 2021/02/22.
//

import UIKit

import FBSDKLoginKit

final class ViewController: UIViewController {

    private let facebookLoginManager = LoginManager()

    private let facebookLoginPermissions = ["public_profile", "email"]

    private lazy var facebookLoginButton: FBLoginButton = {
        let btn = FBLoginButton()
        btn.delegate = self
        btn.permissions = facebookLoginPermissions
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private var isLogin: Bool {
        let isTokenExist = AccessToken.current?.tokenString != nil
        let isTokenValid = !(AccessToken.current?.isExpired ?? true)
        return isTokenExist && isTokenValid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "페이스북 로그인"
        self.view.backgroundColor = .white
        self.view.addSubview(facebookLoginButton)
        
        NSLayoutConstraint.activate([
            facebookLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            facebookLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        if isLogin {
            requestUserInfo()
            facebookLoginManager.logOut()
        } else {
            facebookLoginManager.logIn(permissions: facebookLoginPermissions, from: self, handler: handleFacebookLoginResult(_:_:))
        }
    }

    private func requestUserInfo() {
        Profile.loadCurrentProfile { (profile, error) in
            if let error = error {
                print("에러 \(error.localizedDescription)")
                return
            }
            
            guard let profile = profile else { return }
            
            self.printUserInfo(profile)
        }
    }
    
    private func handleFacebookLoginResult(_ result: LoginManagerLoginResult?, _ error: Error?) {
        if let error = error {
            print("에러 \(error.localizedDescription)")
            return
        }

        if result?.isCancelled == true {
            print("isCancelled")
            return
        }
        
        guard let profile = Profile.current else { return }
        
        self.printUserInfo(profile)
    }
    
    private func printUserInfo(_ profile: Profile) {
        print(profile.userID)
        print(profile.email ?? "")
        print(profile.name ?? "")
        print(profile.imageURL ?? "")
    }
}

extension ViewController: LoginButtonDelegate {

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print("login - didCompleteWith")
        self.handleFacebookLoginResult(result, error)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("DidLogOut")
    }
}

#if DEBUG
import SwiftUI

struct ViewController_Previews: PreviewProvider {

    static var previews: some View {
        ViewControllerRepresentable(target: ViewController())
    }
}
#endif
