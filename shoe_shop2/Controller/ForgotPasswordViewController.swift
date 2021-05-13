//
//  ForgotPasswordViewController.swift
//  shoe_shop2
//
//  Created by Nhat on 5/11/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var btnSendCode: UIButton!
    @IBOutlet weak var textFieldEmail: TextFielDigit!
    
    var isLandScape: Bool = false
    var firtShow: Int = 0 // khi khoi chay se chay 2 lan viewlayoutsubview -> < 2 // la lan chay dau tien
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSendCode.layer.cornerRadius = 8
        textFieldEmail.textField.placeholder = "Enter Your Email"
        
    }
    // view set width = height = 0.5 super with is mean self.view
    // so we want conerradius viewImage/2 = view width/4
    override func viewDidLayoutSubviews() {
        let frame = self.view.safeAreaLayoutGuide.layoutFrame
        viewImage.layer.cornerRadius = frame.width/4
        textFieldEmail.addBottomBorderWithColor(color: UIColor(named: ColorTheme.middleGrayBackground)!, width: 1)
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
