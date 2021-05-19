//
//  CustomTextField.swift
//  shoes_shop_ios
//
//  Created by Nhat on 5/6/21.
//

import UIKit
import Foundation
class CustomTextField: UIView {
    
    @IBOutlet var contenView: UIView!
    @IBOutlet weak var lblTextFieldName: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var texField: UITextField!
    @IBOutlet weak var btnShowHidPassword: UIButton!
    
    fileprivate var showPass: Bool = true
    
    // check text field is right format or not
    var isRightFormat: Bool = false
    
    var isPassword: Bool = false {
        didSet {
            texField.isSecureTextEntry = isPassword
            self.btnShowHidPassword.isHidden = !isPassword
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set up view
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    @IBAction func focusTextfield(_ sender: UITapGestureRecognizer) {
        self.texField.becomeFirstResponder()
    }
    
    private func setUpView() {
        
        let viewFromXib =  Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?[0] as! UIView
        viewFromXib.frame = self.bounds
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.borderColor = UIColor(named: ColorTheme.middleGrayBackground)?.cgColor
        self.borderView.layer.cornerRadius = 8;
        self.lblTextFieldName.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        self.texField.borderStyle = .none
        self.btnShowHidPassword.isHidden = true
        self.texField.delegate = self
        self.addSubview(viewFromXib)
        
    }
    
    @IBAction func showHidePassword(_ sender: Any) {
        texField.isSecureTextEntry = !showPass
        let imageButtonName = showPass ? "show_pass":"hide_pass"
        btnShowHidPassword.setImage(UIImage(named: imageButtonName), for: .normal)
        showPass = !showPass
    }
    

}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.borderView.layer.borderColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currentText = textField.text else {
            return
        }
        if texField.keyboardType == .emailAddress {
            if LogicLogin.shared.isValidEmail(currentText) {
                
                self.isRightFormat = true
                self.borderView.layer.borderColor = UIColor(named: ColorTheme.middleGrayBackground)?.cgColor
            }
            else {
                self.isRightFormat = false
                self.borderView.layer.borderColor = UIColor.red.cgColor
            }
        }
        else if  self.isPassword {
            
            if currentText.count < 8 {
                self.isRightFormat = false
                self.borderView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                self.isRightFormat = true
                self.borderView.layer.borderColor = UIColor(named: ColorTheme.middleGrayBackground)?.cgColor
            }
            
        }
        else if currentText.count == 0 {
            self.isRightFormat = false
            self.borderView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            self.isRightFormat = true
            self.borderView.layer.borderColor = UIColor(named: ColorTheme.middleGrayBackground)?.cgColor
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {
            return true
        }
        // check pass word need min is 8 character
        if texField.isSecureTextEntry {
            if currentText.count >= 7 {
                self.isRightFormat = true
                self.borderView.layer.borderColor = UIColor(red: 0/255, green: 102/255, blue: 255/255, alpha: 1).cgColor
            }
            else if currentText.count <= 6 {
                self.isRightFormat = false
                self.borderView.layer.borderColor = UIColor.red.cgColor
            }
        }
        if currentText.count > 255 {
            return false
        }
        
        return true
    }
}
