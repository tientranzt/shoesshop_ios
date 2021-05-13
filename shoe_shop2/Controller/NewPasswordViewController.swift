//
//  NewPasswordViewController.swift
//  shoe_shop2
//
//  Created by Nhat on 5/13/21.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var textFieldNewPassword: CustomTextField!
    @IBOutlet weak var textFieldConfirmPassword: CustomTextField!
    @IBOutlet weak var btnSave: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textFieldNewPassword.lblTextFieldName.text = " New Password "
        textFieldConfirmPassword.lblTextFieldName.text = " confirm Password "
        textFieldNewPassword.texField.isSecureTextEntry = true
        textFieldConfirmPassword.texField.isSecureTextEntry = true
        btnSave.layer.cornerRadius = 8
    }
    
    override func viewDidLayoutSubviews() {
        let frame = self.view.safeAreaLayoutGuide.layoutFrame
        imageView.layer.cornerRadius = frame.width/4
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
