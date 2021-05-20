//
//  OrderSuccessViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/10/21.
//

import UIKit
import RAMAnimatedTabBarController

class OrderSuccessViewController: UIViewController {
    
    static let identifier = "orderSuccessPage"
    @IBOutlet weak var trackYourOrderButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        CartViewController.isNavToHome = true
    }
    
    override func viewDidLayoutSubviews() {
        //MARK: -- Animaton Tick
        UIView.animate(withDuration: 1) {
            self.backgroundImageView.frame = CGRect(x: self.backgroundImageView.layer.frame.minX, y: self.backgroundImageView.layer.frame.minY + 30 , width: self.backgroundImageView.layer.frame.width, height: self.backgroundImageView.layer.frame.height)}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK: -- Radius View and Button
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundImageView.layer.cornerRadius = backgroundImageView.layer.frame.width / 2
        backgroundImageView.clipsToBounds = true
    }
    
}
