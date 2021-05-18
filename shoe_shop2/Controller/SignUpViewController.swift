//
//  SignUpViewController.swift
//  shoes_shop_ios
//
//  Created by Nhat on 5/6/21.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldUserName: CustomTextField!
    @IBOutlet weak var textFieldEmail: CustomTextField!
    @IBOutlet weak var texttFieldPassword: CustomTextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var switchPolicyAndTerms: CustomSwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        
    }
  
    
    func setUpView() {
        textFieldUserName.lblTextFieldName.text = " USER NAME "
        textFieldEmail.lblTextFieldName.text = " EMAIL ADDRESS "
        textFieldEmail.texField.keyboardType = .emailAddress
        texttFieldPassword.lblTextFieldName.text = " PASSWORD "
        texttFieldPassword.isPassword = true
        btnSignUp.layer.cornerRadius = 8
        switchPolicyAndTerms.isOn = false
    }

    
    @IBAction func signUp(_ sender: Any) {
        
        // block UI dont allow user touch anything at this time
        self.view.isUserInteractionEnabled = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        // check textfield is nil
        if let email = textFieldEmail.texField.text, let password = texttFieldPassword.texField.text, let userName = textFieldUserName.texField.text {
            // if not nil check user accept policy and term
            if email != "" && userName != "" && password != "" {
                if textFieldEmail.isRightFormat && textFieldUserName.isRightFormat && texttFieldPassword.isRightFormat {
                    if switchPolicyAndTerms.isOn {
                        FirebaseManager.shared.signUpWithEmail(email: email, password: password) { (result) in
                            switch result {
                            
                            case .success(_):
                                
                                FirebaseManager.shared.insertUser(userName: userName, Email: email)
                                self.navigationController?.popViewController(animated: true)
                                break
                            case .failure(let error):
                                
                                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                                    self?.view.isUserInteractionEnabled = true
                                    self?.navigationItem.setHidesBackButton(false, animated: true)
                                })
                                alert.addAction(okayAction)
                                self.present(alert, animated: true, completion: nil)
                                
                                break
                            }
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Policy And Terms", message: "Please accept policy and terms", preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                            self?.view.isUserInteractionEnabled = true
                            self?.navigationItem.setHidesBackButton(false, animated: true)
                        })
                        alert.addAction(okayAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "some data wrong format \n 1. User Name can't be null \n 2. Email need right format \n 3. Password need at least 8 characters", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                        self?.view.isUserInteractionEnabled = true
                        self?.navigationItem.setHidesBackButton(false, animated: true)
                    })
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            // atleat 1 rext field nill
            else {
                let alert = UIAlertController(title: "Error", message: "Some data is null please checkout", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                    self?.view.isUserInteractionEnabled = true
                    self?.navigationItem.setHidesBackButton(false, animated: true)
                })
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}


