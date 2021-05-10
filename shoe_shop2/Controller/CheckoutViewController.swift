//
//  CheckoutViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var viewShipAddress: UIView!
    @IBOutlet weak var txtAddress: UILabel!
    @IBOutlet weak var viewPaymentMethod: UIView!
    @IBOutlet weak var btnOrder: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtAddress.adjustsFontSizeToFitWidth = true
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        // shadown
        // chay sai khi chay iphone 8 , nen cho vao viewDidLayoutSubbiew
        viewShipAddress.layer.borderColor = UIColor(named: "grayMainBackground")?.cgColor
        viewShipAddress.layer.borderWidth = 1
        viewShipAddress.layer.cornerRadius = 8
        
        viewShipAddress.layer.shadowColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1).cgColor
        viewShipAddress.layer.shadowOffset = CGSize.zero
        viewShipAddress.layer.shadowRadius = 5
        viewShipAddress.layer.shadowOffset = .zero
        viewShipAddress.layer.shadowOpacity = 0.2
        
        viewPaymentMethod.layer.borderColor = UIColor(named: "grayMainBackground")?.cgColor
        viewPaymentMethod.layer.borderWidth = 1
        viewPaymentMethod.layer.cornerRadius = 8
        
        viewPaymentMethod.layer.shadowColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1).cgColor
        viewPaymentMethod.layer.shadowOffset = CGSize.zero
        viewPaymentMethod.layer.shadowRadius = 5
        viewPaymentMethod.layer.shadowOffset = .zero
        viewPaymentMethod.layer.shadowOpacity = 0.2
        
        btnOrder.layer.cornerRadius = 8
        
        
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
