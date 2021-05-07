//
//  CustomTextField.swift
//  shoes_shop_ios
//
//  Created by Nhat on 5/6/21.
//

import UIKit

class CustomTextField: UIView {

    @IBOutlet var contenView: UIView!
    @IBOutlet weak var lblTextFieldName: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var texField: UITextField!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set up view
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    
    
    private func setUpView() {
        
        let viewFromXib =  Bundle.main.loadNibNamed("CustomTextField", owner: self, options: nil)?[0] as! UIView
        viewFromXib.frame = self.bounds
        self.addSubview(viewFromXib)
        
    }
}
