//
//  SignUpViewController.swift
//  shoes_shop_ios
//
//  Created by Nhat on 5/6/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var textFieldUserName: CustomTextField!
    @IBOutlet weak var textFieldEmail: CustomTextField!
    @IBOutlet weak var texttFieldPassword: CustomTextField!
    @IBOutlet weak var btnSignUp: UIButton!
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
    }
    @IBAction func signUp(_ sender: Any) {
        
        // code sign up o day
    }

}
