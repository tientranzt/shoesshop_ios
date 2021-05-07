//
//  LastestProductCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit

class LastestProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 8)
    }

}
