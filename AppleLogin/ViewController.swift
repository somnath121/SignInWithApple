//
//  ViewController.swift
//  AppleLogin
//
//  Created by SOMNATH CHATTERJEE on 27/9/19.
//  Copyright © 2019 Somnath. All rights reserved.
//

import UIKit
import AuthenticationServices
class ViewController: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLoginWithAppleDidTap(_ sender: Any) {
        let loginRequest = ASAuthorizationAppleIDProvider().createRequest()
        loginRequest.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [loginRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
        //if
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential //{
                // Create an account in your system.
        let userIdentifier = appleIDCredential!.user
        let userFirstName = appleIDCredential?.fullName?.givenName
        let userLastName = appleIDCredential?.fullName?.familyName
        let userEmail = appleIDCredential?.email
            print("\(userIdentifier) ++ \(String(describing: userFirstName)) ++ \(String(describing: userLastName)) ++ \(String(describing: userEmail))")
                
           /* } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
                print("\(username) ++ \(String(describing: password))")
                //Navigate to other view controller
            }*/
        }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error){
        print(error.localizedDescription)
    }
}

