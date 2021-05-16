//
//  ProductCollectionViewCell.swift
//  shoes_shop_ios
//
//  Created by tientran on 05/05/2021.
//

import UIKit
import SkeletonView

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
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
        containerView.showAnimatedSkeleton()
    }
    
    func  heiAnimation()  {
        containerView.hideSkeleton()
    }
    
    func configureCell(product : ProductModel)  {
        self.productName.text = product.productName
        self.productPrice.text = "$\(product.price)"
        productImage.tintColor = UIColor(named: ColorTheme.subGrayBackground)!
        self.productImage.sd_setImage(with: URL(string: product.image)!, placeholderImage: UIImage(systemName: "circles.hexagonpath") , options: .continueInBackground, completed: nil)
        self.containerView.backgroundColor = UIColor(named: product.colorCode)
       
    }
    
    override func layoutSubviews() {
        containerView.roundedAllSide(with: 8)
        heartButton.layer.cornerRadius = heartButton.frame.size.height / 2
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        isHeartClicked = !isHeartClicked
        print("button tapped")
    }
}
