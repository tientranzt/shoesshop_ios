//
//  RootTabbarViewController.swift
//  shoe_shop2
//
//  Created by tientran on 12/05/2021.
//

import UIKit
import FirebaseAuth
import RAMAnimatedTabBarController
class RootTabbarViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let tabController = CustomTabBarController()
        //        tabController.modalPresentationStyle = .fullScreen
        //
        //        let homeNav = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(identifier: "navHomePage") as! UINavigationController
        //        present(homeNav, animated: true, completion: nil)
        
        //        tabBar.isTranslucent = false
        //        tabBar.backgroundColor = UIColor(named: ColorTheme.mainWhiteBackground)
        //
        //        let navLoginVC = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        //
        //        if let _ = viewControllers?.last {
        //            viewControllers![3] = navLoginVC
        //        }
        //
        //        if let firstVC = viewControllers?.first {
        //            let tab = UITabBarItem()
        //
        //        }
    }
    
}

class CustomTabBarController : RAMAnimatedTabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNav = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(identifier: "navHomePage") as! UINavigationController
        
        let notificationNav = UIStoryboard(name: "Notification", bundle: nil).instantiateViewController(identifier: "navNotificationPage") as! UINavigationController
        
        let cartNav = UIStoryboard(name: "CartPage", bundle: nil).instantiateViewController(identifier: "navCartPage") as! UINavigationController
        
        var accountNav: UINavigationController?
        if FirebaseManager.shared.isSignIn(){
            accountNav = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "navAccountPage") as? UINavigationController
            
        }
        else {
            accountNav = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as? UINavigationController
        }
        
        homeNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        
        notificationNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"))
        
        cartNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        
        guard let realAccountNav = accountNav else {
            return
        }
        
        realAccountNav.tabBarItem = RAMAnimatedTabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        (homeNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (notificationNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (cartNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        (realAccountNav.tabBarItem as? RAMAnimatedTabBarItem)?.animation   = RAMBounceAnimation()
        
        setViewControllers([homeNav, notificationNav, cartNav, realAccountNav], animated: true)
        
    }
    
    
}

