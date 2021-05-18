//
//  RootTabbarViewController.swift
//  shoe_shop2
//
//  Created by tientran on 12/05/2021.
//

import UIKit
import FirebaseAuth
import RAMAnimatedTabBarController
import FirebaseAuth

class RootTabbarViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class CustomTabBarController : RAMAnimatedTabBarController{
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNav = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(identifier: "navHomePage") as! UINavigationController
        
        let notificationNav = UIStoryboard(name: "Notification", bundle: nil).instantiateViewController(identifier: "navNotificationPage") as! UINavigationController
        
        let cartNav = UIStoryboard(name: "CartPage", bundle: nil).instantiateViewController(identifier: "navCartPage") as! UINavigationController
        
        let loginNav = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        
        let accountNav = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as! UINavigationController
        
        homeNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
            
        notificationNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"))
        
        cartNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        accountNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        loginNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
                
        
        (homeNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (notificationNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (cartNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (accountNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (loginNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()

        if user != nil {
            setViewControllers([homeNav, notificationNav, cartNav, accountNav ], animated: true)
        }
        else {
            setViewControllers([homeNav, notificationNav, cartNav, loginNav ], animated: true)
        }
        
    }
}
