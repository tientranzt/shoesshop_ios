//
//  OrderSuccessViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/10/21.
//

import UIKit
class OrderSuccessViewController: UIViewController {
    
    static let identifier = "orderSuccessPage"
    @IBOutlet weak var trackYourOrderButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLayoutSubviews() {
        //MARK: -- Animaton Tick
        UIView.animate(withDuration: 1) {
            self.backgroundImageView.frame = CGRect(x: self.backgroundImageView.layer.frame.minX, y: self.backgroundImageView.layer.frame.minY + 30 , width: self.backgroundImageView.layer.frame.width, height: self.backgroundImageView.layer.frame.height)}
    }
    
    //MARK: -- Radius View and Button
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundImageView.layer.cornerRadius = backgroundImageView.layer.frame.width / 2
        backgroundImageView.clipsToBounds = true
        trackYourOrderButton.roundedAllSide(with: 8)
    }

    @IBAction func trackOrderAction(_ sender: Any) {
        let orderSuccessPageVc = UIStoryboard(name: "AccountPage", bundle: nil).instantiateViewController(identifier: "orderHistoryVC") as! OrderHistoryViewController
        self.navigationController?.pushViewController(orderSuccessPageVc, animated: true)
    }
}
