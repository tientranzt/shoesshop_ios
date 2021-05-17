//
//  LogicTextfield.swift
//  shoe_shop2
//
//  Created by Nhat on 5/16/21.
//

import Foundation

class LogicTextfield {
    
    static let shared = LogicTextfield()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
