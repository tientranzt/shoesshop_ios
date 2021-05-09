//
//  UpdateUserInformationViewController.swift
//  shoe_shop2
//
//  Created by tientran on 09/05/2021.
//

import UIKit

class UpdateUserInformationViewController: UIViewController {

    @IBOutlet weak var avartarImage: UIImageView!
    @IBOutlet weak var containerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        avartarImage.layer.cornerRadius = avartarImage.frame.height / 2
        avartarImage.clipsToBounds = true
        containerStackView.roundedAllSide(with: 25)
    }

}
