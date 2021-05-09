//
//  AccountViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/7/21.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var orderHistoryImage: UIImageView!
    @IBOutlet weak var updateInfoImage: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var nextButton1: UIButton!
    @IBOutlet weak var nextButton2: UIButton!
    @IBOutlet weak var nextButton3: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        borderViews()
    }
    

    private func borderViews(){
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        orderHistoryImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        updateInfoImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        infoImage.layer.cornerRadius = orderHistoryImage.frame.height / 2
        nextButton1.roundedAllSide(with: 8)
        nextButton2.roundedAllSide(with: 8)
        nextButton3.roundedAllSide(with: 8)
        signOutButton.roundedAllSide(with: 8)
        
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            let orderHistoryVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "orderHistoryVC") as! OrderHistoryViewController
            navigationController?.pushViewController(orderHistoryVC, animated: true)
            break
            
        case 1:
            
            let updateUserInfoVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "updateUserInfo") as! UpdateUserInformationViewController
            navigationController?.pushViewController(updateUserInfoVC, animated: true)
            
            break
            
        case 2:
            
            let infoUserInfoVC = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "userInfo") as! UserInformationViewController
            navigationController?.pushViewController(infoUserInfoVC, animated: true)
            
            break
            
        default:
            break
        }
       
    }
    
}
