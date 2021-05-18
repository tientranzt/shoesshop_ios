//
//  ForgotPasswordViewController.swift
//  shoe_shop2
//
//  Created by Nhat on 5/11/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var btnSendCode: UIButton!
    @IBOutlet weak var textFieldEmail: TextFielDigit!
    
    var isLandScape: Bool = false
    var firtShow: Int = 0 // khi khoi chay se chay 2 lan viewlayoutsubview -> < 2 // la lan chay dau tien
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        btnSendCode.layer.cornerRadius = 8
        textFieldEmail.textField.placeholder = " Enter Your Email "
        
    }
    // view set width = height = 0.5 super with is mean self.view
    // so we want conerradius viewImage/2 = view width/4
    override func viewDidLayoutSubviews() {
        let frame = self.view.safeAreaLayoutGuide.layoutFrame
        viewImage.layer.cornerRadius = frame.width/4
        textFieldEmail.addBottomBorderWithColor(color: UIColor(named: ColorTheme.middleGrayBackground)!, width: 1)
    }
    @IBAction func closeScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendLinkResetPassword(_ sender: Any) {
 
        btnSendCode.isUserInteractionEnabled = false
        textFieldEmail.textField.isEnabled = false
        if let email = textFieldEmail.textField.text {
            if LogicLogin.shared.isValidEmail(email) {

                FirebaseManager.shared.sendEmailResetPassword(email: email) { (result) in
                    switch result {
                    case .success(_):
                        let alert = UIAlertController(title: " Success ", message: "Send link to reset password success, please check your email", preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in

                            self?.dismiss(animated: true, completion: nil)
                        })
                        alert.addAction(okayAction)

                        self.present(alert, animated: true, completion: nil)
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                            self?.btnSendCode.isUserInteractionEnabled = true
                            self?.textFieldEmail.textField.isEnabled = true
                        })
                        alert.addAction(okayAction)
                        self.present(alert, animated: true, completion: nil)

                    }
                }
            }
            else {
                let alert = UIAlertController(title: " Error ", message: "Please check your email and try again! ", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                    self?.btnSendCode.isUserInteractionEnabled = true
                    self?.textFieldEmail.textField.isEnabled = true
                })
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
