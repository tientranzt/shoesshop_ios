//
//  LoginViewController.swift
//  shoes_shop_ios
//
//  Created by tientran on 04/05/2021.
//

import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import RAMAnimatedTabBarController

class HomeLoginViewController: UIViewController {
    
    @IBOutlet weak var btnContinueWithFaceook: UIButton!
    @IBOutlet weak var btnUserEmail: UIButton!
    @IBOutlet weak var btnContinueWithApple: UIButton!
    
    let loginFacebookButton = FBLoginButton()
    let loginAppleButton = ASAuthorizationAppleIDButton()
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.view.isUserInteractionEnabled = true
    }
    func setUpView() {
        btnContinueWithApple.layer.cornerRadius = 8
        btnContinueWithFaceook.layer.cornerRadius = 8
        btnUserEmail.layer.cornerRadius = 8
        btnUserEmail.layer.borderColor = UIColor(named: ColorTheme.mainBlackBackground)?.cgColor
        btnUserEmail.layer.borderWidth = 0.5
        
        // use to call acction login with facebook in own free button
        loginFacebookButton.isHidden = true
        loginFacebookButton.delegate = self
        self.view.addSubview(loginFacebookButton)
        
        // use to call acction login with apple in own free button
        loginAppleButton.isHidden = true
        loginAppleButton.addTarget(self, action: #selector(signByApple), for: .touchUpInside)
        self.view.addSubview(loginAppleButton)
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        // call acction of FBlogin button
        loginFacebookButton.sendActions(for: .touchUpInside)
    }
    @IBAction func loginWithApple(_ sender: Any) {
        
        loginAppleButton.sendActions(for: .touchUpInside)
    }
    // MARK: - function for login with apple
    
    @objc func signByApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    //function random Nonce string to send to fireBase to hash
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func loginWithFacebookOrApple(credential: AuthCredential) {
        
        FirebaseManager.shared.login(credential: credential) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.goToUserProfile()
            case .failure(let error):
                // need logout with apple if login with apple enable
                LoginManager().logOut()
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                    self?.view.isUserInteractionEnabled = true
                })
                alert.addAction(okayAction)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - FBloginButton Delegate

extension HomeLoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let  _ = error {
            // do nothing
            return
        }
        guard let realResult = result else {
            // do nothing
            return
        }
        if realResult.isCancelled {
            return
        }
        // sign in success need login with fire base
        if let accessToken = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            loginWithFacebookOrApple(credential: credential)
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // at this time od no thing in here
        print("User logged out")
    }
    
}


// MARK: - signin with apple
extension HomeLoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identy token")
                return
            }
            
            guard let idTokenString = String(data: appIDToken, encoding: .utf8) else {
                print("Unable to fetch identy token")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            loginWithFacebookOrApple(credential: credential)
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}


extension HomeLoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


// MARK: - go to user profile

extension HomeLoginViewController {
    
    private func goToUserProfile() {
        let tabbar = self.navigationController?.tabBarController as! CustomTabBarController
        let navAccountVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as! UINavigationController
        navAccountVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        (navAccountVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        if let _ = tabbar.viewControllers?.last{
            tabbar.viewControllers![3] = navAccountVC
            tabbar.setSelectIndex(from: 0, to: 3)
        }
    }
}

