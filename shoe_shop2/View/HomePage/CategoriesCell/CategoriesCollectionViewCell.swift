//
//  CategoriesCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 25)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // a

}
