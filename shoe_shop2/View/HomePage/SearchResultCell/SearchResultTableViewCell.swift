//
//  SearchResultTableViewCell.swift
//  shoe_shop2
//
//  Created by tientran on 17/05/2021.
//

import UIKit
import SDWebImage

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var shoeProduct: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func initCell(product : ProductModel) {
        
        shoeProduct.sd_setImage(with: URL(string: product.image)!, placeholderImage: UIImage(systemName: "circles.hexagonpath"), options: .continueInBackground, completed: nil)
        productTitle.text = product.productName
        productDescription.text = "\(product.price)$"
        shoeProduct.backgroundColor =  UIColor(named: product.colorCode)
    }
    
    func configureUI() {
        shoeProduct.roundedAllSide(with: 8)
        containerView.roundedAllSide(with: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
