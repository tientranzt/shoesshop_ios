//
//  PaymentCashMethod.swift
//  shoe_shop2
//
//  Created by Nhat on 5/9/21.
//

import UIKit

class PaymentCashMethod: UIView {

    @IBOutlet weak var isChecked: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
        
        let viewFromXib =  Bundle.main.loadNibNamed("PaymentCashMethod", owner: self, options: nil)?[0] as! UIView
        viewFromXib.frame = self.bounds
        
        self.addSubview(viewFromXib)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
    }
}
