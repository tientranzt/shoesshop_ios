//
//  EnterCodeResetPassViewController.swift
//  shoe_shop2
//
//  Created by Nhat on 5/12/21.
//

import UIKit

class VerifyEmailCodeViewController: UIViewController {

    @IBOutlet weak var textFieldNumber1: TextFielDigit!
    @IBOutlet weak var textFieldNumber2: TextFielDigit!
    @IBOutlet weak var textFieldNumber3: TextFielDigit!
    @IBOutlet weak var textFieldNumber4: TextFielDigit!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var btnVerify: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    

    func setUpView() {
        
        textFieldNumber1.textField.delegate = self
        textFieldNumber2.textField.delegate = self
        textFieldNumber3.textField.delegate = self
        textFieldNumber4.textField.delegate = self
        
        btnVerify.layer.cornerRadius = 8
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

extension VerifyEmailCodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentString = textField.text {
            if currentString.count < 1 && string.count > 0 {
                
                switch textField {
                case textFieldNumber1.textField:
                    textFieldNumber2.textField.becomeFirstResponder()
                    break
                case textFieldNumber2.textField:
                    textFieldNumber3.textField.becomeFirstResponder()
                    break
                case textFieldNumber3.textField:
                    textFieldNumber4.textField.becomeFirstResponder()
                    break
                case textFieldNumber4.textField:
                    textFieldNumber4.textField.resignFirstResponder()
                    break
                default:
                    break
                }
                textField.text = string
            }
        }
        return true
    }
}
