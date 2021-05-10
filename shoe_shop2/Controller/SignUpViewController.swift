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
        
        textFieldUserName.borderView.layer.borderWidth = 1
        textFieldUserName.borderView.layer.borderColor = UIColor.gray.cgColor
        textFieldUserName.borderView.layer.cornerRadius = 8;
        textFieldUserName.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        textFieldUserName.texField.borderStyle = .none
        textFieldUserName.lblTextFieldName.text = " USER NAME "
        
        textFieldEmail.borderView.layer.borderWidth = 1
        textFieldEmail.borderView.layer.borderColor = UIColor.gray.cgColor
        textFieldEmail.borderView.layer.cornerRadius = 8;
        textFieldEmail.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        textFieldEmail.texField.borderStyle = .none
        textFieldEmail.lblTextFieldName.text = " EMAIL ADDRESS "
        
        texttFieldPassword.borderView.layer.borderWidth = 1
        texttFieldPassword.borderView.layer.borderColor = UIColor.gray.cgColor
        texttFieldPassword.borderView.layer.cornerRadius = 8;
        texttFieldPassword.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        texttFieldPassword.texField.borderStyle = .none
        texttFieldPassword.lblTextFieldName.text = " PASSWORD "
        
        btnSignUp.layer.cornerRadius = 8
    }
    @IBAction func signUp(_ sender: Any) {
        
        // code sign up o day
    }

}
