//
//  OrderSuccessViewController.swift
//  shoe_shop2
//
//  Created by Nguyen Thanh Phuc on 5/10/21.
//

import UIKit

class OrderSuccessViewController: UIViewController {
      
    @IBOutlet weak var trackYourOrderButton: UIButton!
    @IBOutlet weak var tickImage: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundImageView.layer.cornerRadius = backgroundImageView.layer.frame.width / 2
        backgroundImageView.clipsToBounds = true
        trackYourOrderButton.roundedAllSide(with: 8)

        
    }

}
