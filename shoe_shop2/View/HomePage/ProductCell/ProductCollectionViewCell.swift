//
//  ProductCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 8)
    }

}
