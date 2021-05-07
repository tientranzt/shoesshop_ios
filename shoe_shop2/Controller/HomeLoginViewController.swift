//
//  LoginViewController.swift
//  shoes_shop_ios
//
//  Created by tientran on 04/05/2021.
//

import UIKit

class HomeLoginViewController: UIViewController {

    @IBOutlet weak var btnContinueWithFaceook: UIButton!
    @IBOutlet weak var btnUserEmailOrPhone: UIButton!
    
    @IBOutlet weak var btnContinueWithApple: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    
    func setUpView() {
        btnContinueWithApple.layer.cornerRadius = 8
        btnContinueWithFaceook.layer.cornerRadius = 8
        btnUserEmailOrPhone.layer.cornerRadius = 8
        btnUserEmailOrPhone.layer.borderColor = UIColor.gray.cgColor
        btnUserEmailOrPhone.layer.borderWidth = 1
      
    }
    
    @IBAction func moveToLogin(_ sender: Any) {
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
