//
//  ContentView.swift
//  AppleLogin
//
//  Created by lee on 2021/05/27.
//

import UIKit
import AuthenticationServices

final class ViewController: UIViewController {

    private let loginButton: ASAuthorizationAppleIDButton = {
        let view = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func appleLogin() {
        let appleIdRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIdRequest.requestedScopes = [.email, .fullName]
        
        let authController = ASAuthorizationController(authorizationRequests: [appleIdRequest])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }

    private func checkCredentialState(credential: ASAuthorizationAppleIDCredential) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: credential.user) { (state, error) in
            switch state {
            case .authorized:
                // The Apple ID credential is valid. Show Home UI Here
                print("authorized")
            case .revoked:
                // The Apple ID credential is revoked. Show SignIn UI Here.
                print("revoked")
            case .notFound:
                // No credential was found. Show SignIn UI Here.
                print("notFound")
            default:
                break
            }
        }
    }
}

extension ViewController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // Create an account in your system.
        if let authCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let userIdentifier = authCredential.user
            let userEmail = authCredential.email ?? ""
            let familyName = authCredential.fullName?.familyName ?? ""
            let givenName = authCredential.fullName?.givenName ?? ""

            print("id: \(userIdentifier), email: \(userEmail) name: \(givenName) \(familyName)")

            checkCredentialState(credential: authCredential)
        }
        
        // Navigate to other view controller
        if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let name = passwordCredential.user
            let password = passwordCredential.password
            print("name: \(name), password: \(password)")
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("에러 : \(error.localizedDescription)")
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

#if DEBUG
import SwiftUI

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ViewRepresentable(target: ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline))
                .previewLayout(.fixed(width: 260, height: 60))
            
            ViewRepresentable(target: ASAuthorizationAppleIDButton(type: .signIn, style: .black))
                .previewLayout(.fixed(width: 260, height: 60))
            
            ViewRepresentable(target: ASAuthorizationAppleIDButton(type: .signUp, style: .white))
                .previewLayout(.fixed(width: 260, height: 60))
            
            ViewRepresentable(target: ASAuthorizationAppleIDButton(type: .continue, style: .black))
                .previewLayout(.fixed(width: 260, height: 60))
        }
    }
}
#endif
