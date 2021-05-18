//
//  UserInformationViewController.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class UserInformationViewController: UIViewController {

    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPhoneNumber: UITextField!
    @IBOutlet weak var textfieldLocation: UITextField!
    @IBOutlet weak var avartarImage: UIImageView!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        avartarImage.layer.cornerRadius = avartarImage.frame.height / 2
        avartarImage.clipsToBounds = true
    }
    
    func setupView() {
        guard let realUser = self.user else {
            return
        }
        
        DispatchQueue.main.async {
            self.avartarImage.sd_setImage(with: URL(string: realUser.imgAvatar), placeholderImage: UIImage(named: "avatar"), options: .continueInBackground, completed: nil)
            self.textfieldLocation.text =  realUser.shipAddress
            self.textfieldEmail.text = realUser.email
            self.textfieldUserName.text = realUser.userName
            self.textfieldPhoneNumber.text = realUser.phoneNumber
        }
    }

}
