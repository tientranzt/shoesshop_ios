//
//  ProductCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    
    var isHeartClicked : Bool = false {
        didSet {
            if isHeartClicked {
                heartButton.tintColor = .red
                
            } else {
                heartButton.tintColor = UIColor(named: ColorTheme.middleGrayBackground)
            }
        }
    }
    
    func updateHeart(state : Bool) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.tintColor = UIColor(named: ColorTheme.middleGrayBackground)

    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 8)
        heartButton.layer.cornerRadius = heartButton.frame.size.height / 2
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        isHeartClicked = !isHeartClicked
        print("button tapped")
    }
    // a
}
