//
//  RootTabbarViewController.swift
//  shoe_shop2
//
//  Created by tientran on 12/05/2021.
//

import UIKit
import FirebaseAuth
class RootTabbarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()

        let navLoginVC = UIStoryboard(name: "HomeLogin", bundle: nil).instantiateViewController(identifier: "navHomeLogin") as! UINavigationController
        
        if let _ = viewControllers?.last {
            viewControllers![3] = navLoginVC
        }
       
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
