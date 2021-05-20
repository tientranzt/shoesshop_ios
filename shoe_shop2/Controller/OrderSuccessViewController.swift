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
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = false
        CartViewController.isNavToHome = true
    }
    @IBAction func pressTrackYourOrder(_ sender: Any) {
        let tabbar = self.navigationController?.tabBarController as! CustomTabBarController
        
        
        let historyVC = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        
        historyVC.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        (historyVC.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        if let _ = tabbar.viewControllers?.last{
            tabbar.viewControllers![3] = historyVC
            tabbar.setSelectIndex(from: 2, to: 3)
        }
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
